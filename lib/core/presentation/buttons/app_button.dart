import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, this.onPressed, required this.title});

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // Set your desired color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8.0,
          ), // Set your desired border radius
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ), // Set padding
      ),
      child: Text(
        title, // Button text
        style: TextStyle(
          color: Colors.white, // Text color
          fontSize: 16.0, // Text size
        ),
      ),
    );
  }
}
