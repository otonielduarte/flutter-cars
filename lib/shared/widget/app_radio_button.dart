import 'package:flutter/material.dart';

class AppRadioButton extends StatelessWidget {
  final Function _onChange;
  final String _label;
  final int _value;
  final int _radioIndex;

  const AppRadioButton(
    this._label,
    this._value,
    this._onChange,
    this._radioIndex,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Radio(
          value: _value,
          groupValue: _radioIndex,
          onChanged: (value) => _onChange(value),
        ),
        Text(
          _label,
          style: TextStyle(color: Colors.blue, fontSize: 15),
        )
      ],
    );
  }
}
