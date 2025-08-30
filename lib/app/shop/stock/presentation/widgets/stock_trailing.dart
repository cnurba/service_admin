// stock_trailing.dart
import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/price/presentation/widget/number_format.dart';

class StockTrailing extends StatelessWidget {
  const StockTrailing({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 60,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [NumberFormatter()],
              decoration: const InputDecoration(
                labelText: 'Units',
                isDense: true,
              ),
              // onChanged: onUnitsChanged,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [NumberFormatter()],
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                labelText: 'Stock',
                isDense: true,
              ),
              // onChanged: onStockChanged,
            ),
          ),
        ],
      ),
    );
  }
}
