import 'package:flutter/material.dart';

class ProductField extends StatelessWidget {
   const ProductField({
    super.key,
    required this.onChanged,
    required this.title,
    this.initialValue = '',
  });

  final String initialValue;
  final void Function(String) onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Пожалуйста, введите ${title.toLowerCase()}";
        }
        return null;
      },
      decoration: InputDecoration(labelText: title),
      onChanged: onChanged,
    );
  }
}
