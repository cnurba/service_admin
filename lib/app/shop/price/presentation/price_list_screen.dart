import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/price/application/price/price_controller.dart';
import 'package:service_admin/app/shop/price/application/set_price_provider/set_price_controller.dart';
import 'package:service_admin/app/shop/price/domain/model/set_price_model.dart';
import 'package:service_admin/app/shop/price/presentation/price_filter_widget.dart';
import 'package:service_admin/app/shop/price/presentation/widget/number_format.dart';

class PriceListScreen extends ConsumerStatefulWidget {
  const PriceListScreen({super.key});

  @override
  ConsumerState<PriceListScreen> createState() => _PriceListScreenState();
}

class _PriceListScreenState extends ConsumerState<PriceListScreen> {
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en');

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prices")),
      body: Consumer(
        builder: (context, ref, child) {
          final prices = ref.watch(priceProvider);
          return ListView(
            children: [
              PriceFilterWidget(
                onPriceTypeSelected: (priceTypeUuid) {
                  ref.read(priceProvider.notifier).loadPrices(priceTypeUuid);
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: prices.length,
                itemBuilder: (context, index) {
                  final item = prices[index];
                  return ListTile(
                    selected: ref
                        .watch(setPriceProvider)
                        .items
                        .any(
                          (e) =>
                              e.productUuid == item.productUuid &&
                              e.productPropertyUuid == item.productUuid,
                        ),

                    title: Text(prices[index].productName),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("UnitName: ${prices[index].unitName}"),
                        Text(
                          "Stock: ${numberFormat.format(prices[index].stock)}",
                        ),
                        Text(
                          "Old Price: ${numberFormat.format(prices[index].oldPrice)}",
                        ),
                      ],
                    ),

                    trailing: SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [NumberFormatter()],
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          labelText: 'Новая цена',
                          isDense: true,
                        ),
                        onChanged: (value) {
                          final price = double.tryParse(value);
                          if (price != null) {
                            ref
                                .read(setPriceProvider.notifier)
                                .setPriceItems(
                                  SetPriceModel(
                                    productUuid: item.productUuid,
                                    productPropertyUuid: item.productUuid,
                                    price: price,
                                  ),
                                );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) {
          final _newPrices = ref.watch(setPriceProvider);
          return FloatingActionButton.extended(
            onPressed: () {
              ref.read(setPriceProvider.notifier).postPrices();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Новые цены отправлены ✅")),
              );
            },
            label: Text(
              "Выбрано ${_newPrices.items.length} строк(а)\nУстановить новые цены",
              textAlign: TextAlign.center,
            ),
            icon: const Icon(Icons.check),
            backgroundColor: Colors.yellow[700],
          );
        },
      ),
    );
  }
}
