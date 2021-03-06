import 'package:cars/shared/widget/app_text.dart';
import 'package:flutter/material.dart';

class AppTextError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            'List cars not found',
            fontSize: 24,
          ),
          AppText(
            'Try again',
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
