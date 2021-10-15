import 'package:flutter/material.dart';

class SnackBarUtils {
  static void showSnackBar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}