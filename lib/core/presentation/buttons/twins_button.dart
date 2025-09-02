
import 'package:flutter/material.dart';

class TwinsButton extends StatelessWidget {
  const TwinsButton({super.key, this.label1, this.label2, this.onPressed1, this.onPressed2});

  final String? label1;
  final String? label2;
  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed1,
            child: Text(label1??'Отмена'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed2,
            child: Text(label1??'Сохранить'),
          ),
        ),
      ],
    );
  }
}
