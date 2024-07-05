import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tester/components/button.dart';

class SuccessBooking extends StatelessWidget {
  const SuccessBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: Lottie.asset('assets/success.json')),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'Successfully Booked',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Button(
                width: double.infinity,
                title: 'Back to Home Page',
                onPressed: () => Navigator.of(context).pushNamed('main'),
                disable: false),
          )
        ],
      )),
    );
  }
}
