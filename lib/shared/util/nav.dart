import 'package:flutter/material.dart';

Future push(BuildContext context, Widget widget, {bool replace = false}) {
  final route =
      MaterialPageRoute(builder: (BuildContext routerContext) => widget);

  return replace
      ? Navigator.of(context).pushReplacement(route)
      : Navigator.of(context).push(route);
}
