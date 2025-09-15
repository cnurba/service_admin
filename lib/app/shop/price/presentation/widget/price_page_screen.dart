import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:service_admin/app/shop/price/application/price/price_controller.dart';
import 'package:service_admin/app/shop/price/application/set_price_provider/set_price_controller.dart';
import 'package:service_admin/app/shop/price/domain/model/set_price_model.dart';
import 'package:service_admin/app/shop/price/presentation/widget/number_format.dart';
import 'package:service_admin/app/shop/price/presentation/widget/price_filter_widget.dart';
import 'package:service_admin/core/presentation/text_fields/sized_text_field.dart';

class PricePageScreen extends StatelessWidget {
  const PricePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormat = NumberFormat.decimalPattern('en');

    return Consumer(
      builder: (context, ref, child) {
        final prices = ref.watch(priceProvider);
        return ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            PriceFilterWidget(
              onPriceTypeSelected: (priceTypeUuid) {
                ref
                    .read(setPriceProvider.notifier)
                    .setPriceTypeUuid(priceTypeUuid);
                ref.read(priceProvider.notifier).loadPrices(priceTypeUuid);
              },
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: prices.length,
              itemBuilder: (context, index) {
                final item = prices[index];
                return Card(
                  child: ListTile(
                    selected: ref
                        .watch(setPriceProvider)
                        .items
                        .any((e) => e.priceModel == item),

                    title: Text(prices[index].productName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Характеристика: ${prices[index].productPropertyName}"),
                        Text("Е.И: ${prices[index].unitName}"),
                        Text(
                          "Остаток: ${numberFormat.format(prices[index].stock)}",
                        ),
                        Text(
                          "Старая цена: ${numberFormat.format(prices[index].oldPrice)}",
                        ),
                      ],
                    ),

                    trailing: SizedTextField(
                      key: Key('price_input_${item.productPropertyUuid}'),
                      label: 'Новая цена',
                      widthFactor: 0.25,

                      onChanged: (value) {
                        final price = double.tryParse(value);
                        if (price != null) {
                          ref
                              .read(setPriceProvider.notifier)
                              .setPriceItems(
                                SetPriceModel(priceModel: item, price: price),
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
    );
  }
}
