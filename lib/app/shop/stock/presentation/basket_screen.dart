import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/stock/application/basket_provider/basket_future_post_provider.dart';
import 'package:service_admin/app/shop/stock/application/basket_provider/basket_provider.dart';
import 'package:service_admin/app/shop/stock/presentation/widgets/basket_tile.dart';
import 'package:service_admin/app/shop/stock/presentation/widgets/basket_type_drop_button.dart';
import 'package:service_admin/core/enums/state_type.dart';
import 'package:service_admin/core/extansions/router_extension.dart';
import 'package:service_admin/core/presentation/icons/state_animated_icon.dart';

class BasketScreen extends ConsumerWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(basket.type),
        leading: BackButton(
          onPressed: () async {
            ref.read(basketProvider.notifier).clear();
            context.pop();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: StateAnimatedIcon(stateType: StateType.success),
        label: const Text('Сохранить'),
        onPressed: () async {
          //ref.read(basketProvider.notifier).postStocks();
          final result = await ref.read(basketPostProvider(basket).future);

          if (!result.hasError) {
            showSuccessMessage(context, 'Товар успешно добавлен');
            Future.delayed(const Duration(seconds: 1), () {
              ref.read(basketProvider.notifier).clear();
              Navigator.of(context).pop(true);
            });
            return;
          }

          if (result.hasError) {
            final failure = result;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(failure.message)));
          }
        },
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: basket.items.length,
            itemBuilder: (context, index) {
              final item = basket.items[index];
              return BasketTile(incomeBasketModel: item);
            },
          ),

          const SizedBox(height: 80),
          Divider(),
          ListTile(
            title: const Text(
              'Итого',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              basket.items
                  .fold<double>(
                    0,
                    (previousValue, element) =>
                        previousValue + (element.price * element.stock),
                  )
                  .toStringAsFixed(2),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void showSuccessMessage(BuildContext context, String s) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(s), backgroundColor: Colors.green));
  }
}
