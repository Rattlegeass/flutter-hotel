import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tester/components/button.dart';
import 'package:tester/main.dart';
import 'package:tester/models/auth_model.dart';
import 'package:tester/providers/dio_provider.dart';
import 'package:tester/utils/config.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
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
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    hintText: 'Email Address',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Email',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.email_outlined),
                    prefixIconColor: Colors.black),
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
                                color: Config.primaryColor))),
              ),
              Config.spaceSmall,
              Consumer<AuthModel>(builder: (context, auth, child) {
                return Button(
                    width: double.infinity,
                    title: 'Sign In',
                    onPressed: () async {
                      final token = await DioProvider().getToken(
                          _emailController.text, _passController.text);
                      if (token) {
                        auth.loginSuccess();
                        MyApp.navigatorKey.currentState!.pushNamed('main');
                      }
                    },
                    disable: false);
              })
            ],
          )),
    );
  }
}
