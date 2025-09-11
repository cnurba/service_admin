import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/stock/domain/models/stock.model.dart';

class StockTile extends StatelessWidget {
  final IncomeModel stock;
  final VoidCallback? onSelect;
  final bool isSelected;

  const StockTile({
    super.key,
    required this.stock,
    this.onSelect,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.blueGrey[100] : Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.productName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stock.productPropertyName,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Остаток: ',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        '${stock.stock} ${stock.unitName}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            IconButton(
              onPressed: isSelected ? null : onSelect,
              icon: const Icon(Icons.add_circle_rounded, color: Colors.blue),
              iconSize: 40,
            ),
          ],
        ),
      ),
    );
  }
}
