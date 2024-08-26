import 'package:flutter/material.dart';

void customSnackbar(BuildContext context, String content, Color backgroundColor) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: backgroundColor,
      ),
    );
}

void showSuccessSnackbar(BuildContext context, String message) {
  customSnackbar(
    context,
    message,
    Colors.green,
  );
}

void showErrorSnackbar(BuildContext context, String message) {
  customSnackbar(
    context,
    message,
    Colors.red,
  );
}
