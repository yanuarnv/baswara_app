import 'package:flutter/material.dart';

class Utility {
  final BuildContext context;

  Utility(this.context);

  void showSnackbar(String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color ?? Colors.red,
    ));
  }
}
