import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/price/application/price/price_controller.dart';
import 'package:service_admin/app/shop/price/application/price_provider.dart';
import 'package:service_admin/app/shop/price/application/price_service.dart';
import 'package:service_admin/app/shop/price/application/set_price_provider/set_price_controller.dart';
import 'package:service_admin/app/shop/price/domain/model/price_model.dart';
import 'package:service_admin/app/shop/price/domain/model/price_type_model.dart';
import 'package:service_admin/app/shop/price/domain/model/set_price_model.dart';
import 'package:service_admin/app/shop/price/presentation/price_filter_widget.dart';

class PriceListScreen extends ConsumerStatefulWidget {
  const PriceListScreen({super.key});

  @override
  ConsumerState<PriceListScreen> createState() => _PriceListScreenState();
}

class _PriceListScreenState extends ConsumerState<PriceListScreen> {
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
                    subtitle: Text("Old Price: ${prices[index].oldPrice}"),
                    trailing: SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
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

          // return priceTypesAsync.when(
          //   data: (types) {
          //     if (types.isEmpty)
          //       return const Center(child: Text("No price types"));
          //
          //     // Load the first price type by default
          //     final selectedTypeUuid = types.first.uuid;
          //     final pricesAsync = ref.watch(
          //       pricesByTypeProvider(selectedTypeUuid),
          //     );
          //
          //     return pricesAsync.when(
          //       data: (items) => SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         child: Row(
          //           children: items.map((product) {
          //             _controllers.putIfAbsent(
          //               product.productUuid,
          //               () => TextEditingController(),
          //             );
          //
          //             return Container(
          //               width: 470,
          //               height: 150,
          //               margin: const EdgeInsets.all(8),
          //               padding: const EdgeInsets.all(8),
          //               decoration: BoxDecoration(
          //                 color: Colors.grey[200],
          //                 borderRadius: BorderRadius.circular(12),
          //               ),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Row(
          //                     children: [
          //                       Expanded(
          //                         child: RadioListTile<String>(
          //                           title: const Text(
          //                             'Оптовый',
          //                             style: TextStyle(fontSize: 12),
          //                           ),
          //                           value: 'Оптовый',
          //                           groupValue:
          //                               _newPricesType[product.productUuid] ??
          //                               'Оптовый',
          //                           onChanged: (value) {
          //                             setState(() {
          //                               _newPricesType[product.productUuid] =
          //                                   value!;
          //                             });
          //                           },
          //                           dense: true,
          //                         ),
          //                       ),
          //                       Expanded(
          //                         child: RadioListTile<String>(
          //                           title: const Text(
          //                             'Розничный',
          //                             style: TextStyle(fontSize: 12),
          //                           ),
          //                           value: 'Розничный',
          //                           groupValue:
          //                               _newPricesType[product.productUuid] ??
          //                               'Оптовый',
          //                           onChanged: (value) {
          //                             setState(() {
          //                               _newPricesType[product.productUuid] =
          //                                   value!;
          //                             });
          //                           },
          //                           dense: true,
          //                         ),
          //                       ),
          //                       Expanded(
          //                         child: TextField(
          //                           controller:
          //                               _controllers[product.productUuid],
          //                           keyboardType: TextInputType.number,
          //                           decoration: const InputDecoration(
          //                             labelText: 'Моя цена',
          //                             prefixText: "\$",
          //                             isDense: true,
          //                           ),
          //                           onChanged: (value) {
          //                             final price = int.tryParse(value);
          //                             setState(() {
          //                               if (price != null) {
          //                                 _newPrices[product.productUuid] =
          //                                     price;
          //                               } else {
          //                                 _newPrices.remove(
          //                                   product.productUuid,
          //                                 );
          //                               }
          //                             });
          //                           },
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                   const SizedBox(height: 4),
          //
          //                   Text(
          //                     product.productName,
          //                     style: const TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                   Text("Stock: ${product.stock} ${product.unitName}"),
          //                   Text("Old Price: ${product.oldPrice}"),
          //                 ],
          //               ),
          //             );
          //           }).toList(),
          //         ),
          //       ),
          //       loading: () => const Center(child: CircularProgressIndicator()),
          //       error: (err, stack) => Center(child: Text("Error: $err")),
          //     );
          //   },
          //   loading: () => const Center(child: CircularProgressIndicator()),
          //   error: (err, stack) => Center(child: Text("Error: $err")),
          // );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) {
          final _newPrices = ref.watch(setPriceProvider);
          return FloatingActionButton.extended(
            onPressed: () {},
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
