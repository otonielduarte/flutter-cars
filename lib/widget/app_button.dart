import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function onPressed;
  final String name;

  AppButton(this.name, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 46,
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: () => onPressed(),
          child: Text(name),
        ),
      ),
    );
  }
}
