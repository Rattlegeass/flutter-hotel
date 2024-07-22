import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tester/components/button.dart';
import 'package:tester/main.dart';
import 'package:tester/models/auth_model.dart';
import 'package:tester/providers/dio_provider.dart';
import 'package:tester/utils/config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  bool obsecurePass = true;
  bool obsecureConfirmPass = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelStyle: TextStyle(
                color: Colors.grey), // Color of the label when not focused
            focusColor: Colors.black, // Color of the label when focused
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  labelText: 'Name',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.person_outline),
                  prefixIconColor: Colors.black,
                ),
              ),
              Config.spaceSmall,
              TextFormField(
                controller: _phoneController,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                  labelText: 'Phone Number',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.phone),
                  prefixIconColor: Colors.black,
                ),
              ),
              Config.spaceSmall,
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  hintText: 'Email Address',
                  labelText: 'Email',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.email_outlined),
                  prefixIconColor: Colors.black,
                ),
              ),
              Config.spaceSmall,
              TextFormField(
                controller: _passController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: obsecurePass,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  alignLabelWithHint: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  prefixIconColor: Colors.black,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecurePass = !obsecurePass;
                      });
                    },
                    icon: obsecurePass
                        ? const Icon(Icons.visibility_off_outlined,
                            color: Colors.black38)
                        : const Icon(Icons.visibility_outlined,
                            color: Colors.black),
                  ),
                ),
              ),
              Config.spaceSmall,
              TextFormField(
                controller: _confirmPassController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: obsecureConfirmPass,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                  alignLabelWithHint: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  prefixIconColor: Colors.black,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecureConfirmPass = !obsecureConfirmPass;
                      });
                    },
                    icon: obsecureConfirmPass
                        ? const Icon(Icons.visibility_off_outlined,
                            color: Colors.black38)
                        : const Icon(Icons.visibility_outlined,
                            color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              Config.spaceSmall,
              Consumer<AuthModel>(builder: (context, auth, child) {
                return Button(
                  width: double.infinity,
                  title: 'Sign Up',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final registerUser = await DioProvider().register(
                        _emailController.text,
                        _phoneController.text,
                        _nameController.text,
                        _passController.text,
                      );

                      if (registerUser) {
                        final token = await DioProvider().getToken(
                          _emailController.text,
                          _passController.text,
                        );

                        if (token != null) {
                          auth.loginSuccess();
                          MyApp.navigatorKey.currentState!.pushNamed('main');
                        } else {
                          // Handle token fetch error
                          print('Error fetching token');
                        }
                      } else {
                        // Handle registration error
                        print('Error during registration');
                      }
                    }
                  },
                  disable: false,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
