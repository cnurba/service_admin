import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/stock/application/set_stock_provider/set_stock_controller.dart';
import 'package:service_admin/core/extansions/router_extension.dart';

class SetStockScreen extends ConsumerWidget {
  const SetStockScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stockState = ref.watch(setStockProvider);
    final notifier = ref.read(setStockProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Stocks"),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: stockState.items.length,
        itemBuilder: (context, index) {
          final item = stockState.items[index];
          return ListTile(
            title: Text(item.stockModel.productModel.name),
            subtitle: Text("Qty: ${item.price}, Stock: ${item.unit}"),
            // trailing: IconButton(
            //   icon: const Icon(Icons.delete, color: Colors.red),
            //  // onPressed: () => notifier.deleteStockItem(item),
            // ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.upload),
        label: const Text('Отправить на сервер'),
        onPressed: () async {
         // await notifier.postStocks();
          context.pop();
        },
      ),
    );
  }
}
