import 'package:flutter/material.dart';

Future push(BuildContext context, Widget widget) {
  return Navigator.of(context).push(
    MaterialPageRoute(builder: (BuildContext routerContext) => widget),
  );
}
