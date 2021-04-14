import 'package:flutter/material.dart';

class AppInputText extends StatelessWidget {
  final bool obscureText;
  final TextEditingController controller;
  final String label;
  final String hintText;
  final FormFieldValidator validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const AppInputText({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.validator,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          labelText: label,
          hintText: hintText,
        ),
      ),
    );
  }
}
