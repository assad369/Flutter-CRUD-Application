import 'package:flutter/material.dart';

void buildCustomSnackbar(context,
    {required String contentText, required Color bgColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        contentText,
      ),
      backgroundColor: bgColor,
    ),
  );
}
