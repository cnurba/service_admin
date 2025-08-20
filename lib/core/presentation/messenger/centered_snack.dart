import 'package:flutter/material.dart';

/// create a messenger method that shows a centered snack bar
/// the widget should be a stateless widget

void showCenteredSnackWithAction({
  required BuildContext context,
  required String message,
  void Function()? onTap,
}) {
  final snackBar = SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  Future.delayed(const Duration(seconds: 2), () {
    if (onTap == null) {
      return;
    }
    onTap();
  });
}
