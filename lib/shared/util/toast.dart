import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(message) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black38,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
