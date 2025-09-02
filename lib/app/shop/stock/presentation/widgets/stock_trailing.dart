import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/price/presentation/widget/number_format.dart';
import 'package:service_admin/app/shop/products/domain/models/product_model.dart';
import 'package:service_admin/app/shop/stock/application/set_stock_provider/set_stock_controller.dart';
import 'package:service_admin/app/shop/stock/domain/models/set_stock_model.dart';
import 'package:service_admin/app/shop/stock/domain/models/stock.model.dart';

class StockTrailing extends ConsumerStatefulWidget {
  final ProductModel product;
  const StockTrailing({super.key, required this.product});

  @override
  ConsumerState<StockTrailing> createState() => _StockTrailingState();
}

class _StockTrailingState extends ConsumerState<StockTrailing> {
  final _priceController = TextEditingController();
  final _unitController = TextEditingController();

  void _updateStock() {
    final price = double.tryParse(_priceController.text) ?? 0;
    final unit = double.tryParse(_unitController.text) ?? 0;

    if (price > 0 || unit > 0) {
      final stockModel = StockModel(
        productModel: widget.product,
        stock: 0,
        price: 0,
        amount: 0,
      );

      final item = SetStockModel(
        stockModel: stockModel,
        price: price,
        unit: unit,
      );

     // ref.read(setStockProvider.notifier).setStockItems(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems = ref.watch(setStockProvider).items;
    final isSelected = selectedItems.any(
      (e) =>
          e.stockModel.productModel.id == widget.product.id &&
          (e.price > 0 || e.unit > 0),
    );

    return SizedBox(
      width: 170,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 60,
            child: TextField(
              controller: _unitController,
              onChanged: (_) => _updateStock(),
              keyboardType: TextInputType.number,
              inputFormatters: [NumberFormatter()],
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                labelText: 'Количество',
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 70,
            child: TextField(
              controller: _priceController,
              onChanged: (_) => _updateStock(),
              keyboardType: TextInputType.number,
              inputFormatters: [NumberFormatter()],
              decoration: const InputDecoration(
                labelText: 'Цена',
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
