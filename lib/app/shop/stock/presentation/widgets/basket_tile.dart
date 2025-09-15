import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/stock/application/basket_provider/basket_provider.dart';
import 'package:service_admin/app/shop/stock/domain/models/income_basket_model.dart';
import 'package:service_admin/core/presentation/image/app_image_container.dart';
import 'package:service_admin/core/presentation/text_fields/sized_text_field.dart';

class BasketTile extends StatelessWidget {
  const BasketTile({super.key, required this.incomeBasketModel});

  final IncomeBasketModel incomeBasketModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImageContainer(
              image: incomeBasketModel.incomeModel.imageUrl,
              width: 80,
              height: 80,
              borderRadius: 8.0,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0,
                  offset: Offset(0, 2),
                ),
              ],
              fit: BoxFit.cover,
              placeholder: const Center(child: CircularProgressIndicator()),
              errorWidget: const Icon(Icons.error),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  incomeBasketModel.incomeModel.productName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  incomeBasketModel.incomeModel.productPropertyName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 8),
                Consumer(
                  builder: (context, ref, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedTextField(
                          widthFactor: 0.25,
                          label: 'Количество',
                          onChanged: (value) {
                            ref
                                .read(basketProvider.notifier)
                                .setStock(
                                  double.tryParse(value) ?? 0,
                                  incomeBasketModel.incomeModel,
                                );
                          },
                        ),
                        const SizedBox(width: 8),
                        SizedTextField(
                          widthFactor: 0.20,
                          label: 'Цена',
                          onChanged: (value) {
                            ref
                                .read(basketProvider.notifier)
                                .setPrice(
                                  double.tryParse(value) ?? 0,
                                  incomeBasketModel.incomeModel,
                                );
                          },
                        ),
                        const SizedBox(width: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            incomeBasketModel.amount.toStringAsFixed(2),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
