import 'package:cars/shared/widget/app_text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function onPressed;
  final String name;
  final bool isLoading;

  AppButton(this.name, {required this.onPressed, this.isLoading = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 46,
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: () => onPressed(),
          child: isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : AppText(
                  name,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
