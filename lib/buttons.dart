import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyButtons({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.deepOrange,
      textColor: Colors.white,
      shape: const StadiumBorder(),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
