import 'package:flutter/material.dart';
import 'package:proteam_app/core/theme/color_style.dart';

void circularProgress(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(isabellineColor),
        ),
      );
    },
  );
}