import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/my_product_future_provider.dart';
import 'package:service_admin/app/shop/stock/application/set_stock_provider/set_stock_controller.dart';
import 'package:service_admin/app/shop/stock/presentation/set_stock_screen.dart';
import 'package:service_admin/app/shop/stock/presentation/widgets/stock_trailing.dart';
import 'package:service_admin/core/extansions/router_extension.dart';

class StockListScreen extends ConsumerWidget {
  const StockListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(myProductFutureProvider);
    final stockState = ref.watch(setStockProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Остатки')),
      body: resultAsync.when(
        data: (myProducts) {
          return ListView.builder(
            itemCount: myProducts.length,
            itemBuilder: (context, index) {
              final product = myProducts[index];
              final isSelected = stockState.items.any(
                (item) => item.stockModel.productModel.id == product.id,
              );

              return ListTile(
                title: Text(
                  product.name,
                  style: TextStyle(
                    color: isSelected ? Colors.blue : Colors.black,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                subtitle: Text(
                  "Категория: ${product.categoryName}\nБренд: ${product.brandName}",
                ),
                trailing: StockTrailing(product: product),
              );
            },
          );
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final selectedItems = ref
              .watch(setStockProvider)
              .items
              .where((item) => item.price > 0 || item.unit > 0)
              .toList();

          if (selectedItems.isNotEmpty) {
            context.push(const SetStockScreen());
          }
        },
        label: Builder(
          builder: (context) {
            final selectedItems = ref
                .watch(setStockProvider)
                .items
                .where((item) => item.price > 0 || item.unit > 0)
                .toList();

            final selectedCount = selectedItems.length;
            final totalPrice = selectedItems.fold<double>(
              0,
              (sum, item) => sum + item.price,
            );

            return Text(
              "Выбрано количество $selectedCount, Цена: $totalPrice, \nУстановить",
              textAlign: TextAlign.center,
            );
          },
        ),
        icon: const Icon(Icons.check),
        backgroundColor:
            ref
                .watch(setStockProvider)
                .items
                .any((item) => item.price > 0 || item.unit > 0)
            ? const Color.fromARGB(255, 11, 149, 68)
            : Colors.blue,
      ),
    );
  }
}
