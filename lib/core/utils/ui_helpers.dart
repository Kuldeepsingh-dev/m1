import 'package:flutter/material.dart';

class UIHelpers {
  static void showSnackbar(BuildContext context, String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  // You can add a toast method if you use a package like fluttertoast
  // static void showToast(String message) { ... }
}