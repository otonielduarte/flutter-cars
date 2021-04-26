import 'package:flutter/material.dart';

class AppDialoag extends StatelessWidget {
  final String text;
  final List<Widget>? actions;

  const AppDialoag(this.text, {Key? key, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(text),
        actions: actions,
      ),
    );
  }
}
