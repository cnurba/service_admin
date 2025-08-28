import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/price/application/price_provider.dart';
import 'package:service_admin/app/shop/price/application/price_service.dart';
import 'package:service_admin/app/shop/price/domain/model/price_model.dart';

class PriceListScreen extends ConsumerStatefulWidget {
  const PriceListScreen({super.key});

  @override
  ConsumerState<PriceListScreen> createState() => _PriceListScreenState();
}

class _PriceListScreenState extends ConsumerState<PriceListScreen> {
  final priceService = PriceService(dio: Dio());

  final Map<String, TextEditingController> _controllers = {};
  final Map<String, int> _newPrices = {};
  final Map<String, String> _newPricesType = {}; // Оптовый / Розничный

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prices")),
      body: Consumer(
        builder: (context, ref, child) {
          final priceTypesAsync = ref.watch(priceTypesProvider);

          return priceTypesAsync.when(
            data: (types) {
              if (types.isEmpty)
                return const Center(child: Text("No price types"));

              // Load the first price type by default
              final selectedTypeUuid = types.first.uuid;
              final pricesAsync = ref.watch(
                pricesByTypeProvider(selectedTypeUuid),
              );

              return pricesAsync.when(
                data: (items) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: items.map((product) {
                      _controllers.putIfAbsent(
                        product.productUuid,
                        () => TextEditingController(),
                      );

                      return Container(
                        width: 470,
                        height: 150,
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: const Text(
                                      'Оптовый',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    value: 'Оптовый',
                                    groupValue:
                                        _newPricesType[product.productUuid] ??
                                        'Оптовый',
                                    onChanged: (value) {
                                      setState(() {
                                        _newPricesType[product.productUuid] =
                                            value!;
                                      });
                                    },
                                    dense: true,
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: const Text(
                                      'Розничный',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    value: 'Розничный',
                                    groupValue:
                                        _newPricesType[product.productUuid] ??
                                        'Оптовый',
                                    onChanged: (value) {
                                      setState(() {
                                        _newPricesType[product.productUuid] =
                                            value!;
                                      });
                                    },
                                    dense: true,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller:
                                        _controllers[product.productUuid],
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Моя цена',
                                      prefixText: "\$",
                                      isDense: true,
                                    ),
                                    onChanged: (value) {
                                      final price = int.tryParse(value);
                                      setState(() {
                                        if (price != null) {
                                          _newPrices[product.productUuid] =
                                              price;
                                        } else {
                                          _newPrices.remove(
                                            product.productUuid,
                                          );
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            Text(
                              product.productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Stock: ${product.stock} ${product.unitName}"),
                            Text("Old Price: ${product.oldPrice}"),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text("Error: $err")),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text("Error: $err")),
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) {
          if (_newPrices.isEmpty) return const SizedBox.shrink();

          return FloatingActionButton.extended(
            onPressed: () {
              final priceTypes = ref
                  .read(priceTypesProvider)
                  .maybeWhen(data: (v) => v, orElse: () => []);
              if (priceTypes.isNotEmpty) {
                final selectedTypeUuid = priceTypes.first.uuid;
                final itemsDynamic = ref
                    .read(pricesByTypeProvider(selectedTypeUuid))
                    .maybeWhen(data: (v) => v, orElse: () => []);

                final items = List<PriceModel>.from(
                  itemsDynamic,
                ); // cast to List<PriceModel>
                priceService.sendPricesToServer(
                  items,
                  _newPrices,
                  _newPricesType,
                  context,
                );
              }
            },
            label: Text(
              "Выбрано ${_newPrices.length} строк(а)\nУстановить новые цены",
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
