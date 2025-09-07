import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:service_admin/app/shop/price/application/price/price_controller.dart';
import 'package:service_admin/app/shop/price/application/set_price_provider/set_price_controller.dart';
import 'package:service_admin/app/shop/price/domain/model/set_price_model.dart';
import 'package:service_admin/app/shop/price/presentation/widget/number_format.dart';
import 'package:service_admin/app/shop/price/presentation/widget/price_filter_widget.dart';

class PricePageScreen extends StatelessWidget {
  const PricePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormat = NumberFormat.decimalPattern('en');

    return Consumer(
      builder: (context, ref, child) {
        final prices = ref.watch(priceProvider);
        return ListView(
          children: [
            PriceFilterWidget(
              onPriceTypeSelected: (priceTypeUuid) {
                ref
                    .read(setPriceProvider.notifier)
                    .setPriceTypeUuid(priceTypeUuid);
                ref.read(priceProvider.notifier).loadPrices(priceTypeUuid);
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: prices.length,
              itemBuilder: (context, index) {
                final item = prices[index];
                return Card(
                  elevation: 4,
                  child: ListTile(
                    selected: ref
                        .watch(setPriceProvider)
                        .items
                        .any((e) => e.priceModel == item),

                    title: Text(
                      prices[index].productName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Единица: ${prices[index].unitName}"),
                        Text(
                          "Остатки: ${numberFormat.format(prices[index].stock)}",
                        ),
                        Text(
                          "Старое цено: ${numberFormat.format(prices[index].oldPrice)}",
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
                                  SetPriceModel(priceModel: item, price: price),
                                );
                          }
                        },
                      ),
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
