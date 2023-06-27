import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Alert {

  static void toastmessage(String str) {
    Fluttertoast.showToast(
        msg: str,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}