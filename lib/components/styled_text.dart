import 'package:flutter/material.dart';

class SuperTitleText extends StatelessWidget {
  const SuperTitleText(this.text, {super.key});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }
}

class TitleTextBold extends StatelessWidget {
  const TitleTextBold(this.text, {super.key});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold));
  }
}

class SubTitleText extends StatelessWidget {
  const SubTitleText(this.text, {super.key});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 15));
  }
}

class SuperSubTitleText extends StatelessWidget {
  const SuperSubTitleText(this.text, {super.key});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 13));
  }
}
