
import 'package:flutter/material.dart';

class BasketTypeDropButton extends StatelessWidget {
  const BasketTypeDropButton({super.key, required this.onChanged});

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return  DropdownButton<String>(
      value: 'Приход',
      isExpanded: true,
      items: ['Остаток', 'Приход', 'Продажа', 'Списание']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(value),
          ),
        );
      })
          .toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
    );
  }
}
