import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool bold;
  final Color color;
  final bool justify;

  AppText(
    this.text, {
    this.fontSize = 16,
    this.bold = false,
    this.color = Colors.black,
    this.justify = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: justify ? TextAlign.justify : TextAlign.start,
      style: (TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: !bold ? FontWeight.normal : FontWeight.bold,
      )),
    );
  }
}
