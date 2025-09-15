import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/stock/domain/models/income_model.dart';
import 'package:service_admin/core/presentation/image/app_image_container.dart';

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
    return Stack(
      children: [
        Card(
          color: isSelected ? Colors.blueGrey[100] : Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppImageContainer(
                image: stock.imageUrl,
                borderRadius: 8,
                width: double.infinity,
                height: 120,
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stock.productName,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stock.productPropertyName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: IconButton(
            onPressed: onSelect,
            icon: Icon(Icons.add, color: Colors.green),
          ),
        ),
      ],
    );
  }
}
