import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/my_product_future_provider.dart';
import 'package:service_admin/app/shop/stock/application/set_stock_provider/set_stock_controller.dart';
import 'package:service_admin/app/shop/stock/presentation/set_stock_screen.dart';
import 'package:service_admin/app/shop/stock/presentation/widgets/stock_tile.dart';
import 'package:service_admin/core/extansions/router_extension.dart';

import '../domain/models/stock.model.dart';

class StockListScreen extends ConsumerWidget {
  const StockListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///final resultAsync = ref.watch(myProductFutureProvider);
    ///final resultAsync = ref.watch(setStockProvider).items;
    return Scaffold(
      appBar: AppBar(title: const Text('Остатки')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          // final product = resultAsync[index].stockModel;
          // final isSelected = resultAsync.any(
          //   (item) => item.stockModel.productModel.id == product.id,
          // );

          return StockTile(
            onSelect: () {

            },
            stock: StockModel(
              productName: "Product $index",
              productPropertyName: "Property $index",
              productPropertyUuid: "uuid-$index",
              productUuid: "prod-uuid-$index",
              stock: 255,
              unitName: "шт",
            ),
          );
        },
      ),

      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //
      //   },
      //   // label: Builder(
      //   //   builder: (context) {
      //   //
      //   //
      //   //     return Text(
      //   //       "Выбрано количество $selectedCount, Цена: $totalPrice, \nУстановить",
      //   //       textAlign: TextAlign.center,
      //   //     );
      //   //   },
      //   // ),
      //   icon: const Icon(Icons.check),
      //   backgroundColor:
      //       ref
      //           .watch(setStockProvider)
      //           .items
      //           .any((item) => item.price > 0 || item.unit > 0)
      //       ? const Color.fromARGB(255, 11, 149, 68)
      //       : Colors.blue,
      // ),
    );
  }
}
