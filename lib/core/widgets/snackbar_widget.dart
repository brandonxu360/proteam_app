import 'package:flutter/material.dart';
import 'package:proteam_app/core/theme/color_style.dart';

void snackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: blackColor,
      content: Text(message, style: const TextStyle(color: boneColor),),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.fixed,
      action: SnackBarAction(
        textColor: isabellineColor,
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}
