import 'package:cars/shared/widget/app_text.dart';
import 'package:flutter/material.dart';

class LoadingComponent extends StatelessWidget {
  final String message;

  LoadingComponent({this.message: 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: AppText(
              message,
              bold: true,
            ),
          ),
        ],
      ),
    );
  }
}
