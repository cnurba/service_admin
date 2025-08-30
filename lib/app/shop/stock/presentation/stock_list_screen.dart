import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:service_admin/app/shop/price/application/price/price_controller.dart';
import 'package:service_admin/app/shop/price/application/set_price_provider/set_price_controller.dart';
import 'package:service_admin/app/shop/price/presentation/widget/number_format.dart';
import 'package:service_admin/app/shop/stock/presentation/set_stock_screen.dart';
import 'package:service_admin/app/shop/stock/presentation/widgets/stock_trailing.dart';
import 'package:service_admin/core/extansions/router_extension.dart';

class StockListScreen extends ConsumerStatefulWidget {
  const StockListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StockListScreen();
}

class _StockListScreen extends ConsumerState<StockListScreen> {
  @override
  Widget build(BuildContext context) {
    final prices = ref.watch(priceProvider); // Your real PriceModel list
    final selectedPrices = ref.watch(setPriceProvider);
    final numberFormat = NumberFormat.decimalPattern('en');
    return Scaffold(
      appBar: AppBar(title: Text('Stock')),
      body: ListView.builder(
        itemCount: prices.length,
        itemBuilder: (context, index) {
          final item = prices[index];
          final isSelected = selectedPrices.items.any(
            (e) => e.priceModel.productUuid == item.productUuid,
          );

          return ListTile(
            selected: isSelected,
            title: Text(item.productName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Unit: ${item.unitName}'),
                Text('Stock: ${numberFormat.format(item.stock)}'),
                Text('Old Price: ${numberFormat.format(item.oldPrice)}'),
              ],
            ),
            trailing: StockTrailing(),
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) {
          final _newPrices = ref.watch(setPriceProvider);
          return FloatingActionButton.extended(
            onPressed: () {
              context.push(SetStockScreen());
            },
            label: Text(
              "Выбрано ${_newPrices.items.length} строк(а)\nУстановить остатки",
              textAlign: TextAlign.center,
            ),
            icon: const Icon(Icons.check),
            backgroundColor: const Color.fromARGB(255, 11, 149, 68),
          );
        },
      ),
    );
  }
}
