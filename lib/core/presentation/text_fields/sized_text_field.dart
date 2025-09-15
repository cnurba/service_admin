import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SizedTextField extends StatelessWidget {
  const SizedTextField({
    super.key,
    this.onChanged,
    required this.label,
    this.widthFactor = 0.2,
    this.initialValue = "",
  });

  final String label;
  final Function(String)? onChanged;
  final double widthFactor; // 20% of screen width
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      child: TextFormField(
        inputFormatters: [
          /// Format input double only with 2 decimal places
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        initialValue: initialValue,
        textAlign: TextAlign.right,
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodySmall,
          border: const OutlineInputBorder(),
          isDense: true,
          // Reduces height of the TextField
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 12.0,
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
      ),
    );
  }
}
