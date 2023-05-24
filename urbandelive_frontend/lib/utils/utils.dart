import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      duration: const Duration(seconds: 6),
      content: Text(content),
    ),
  );
}
