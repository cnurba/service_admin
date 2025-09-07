import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/price/application/price/price_controller.dart';
import 'package:service_admin/app/shop/price/application/set_price_provider/set_price_controller.dart';
import 'package:service_admin/app/shop/price/application/set_price_provider/set_price_state.dart';
import 'package:service_admin/app/shop/price/presentation/widget/set_price_tile.dart';
import 'package:service_admin/core/extansions/router_extension.dart';
import 'package:service_admin/core/presentation/errors/state_wrapper.dart';

class SetPriceScreen extends ConsumerWidget {
  const SetPriceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SetPriceState state = ref.watch(setPriceProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Устанавить цены"),
        leading: BackButton(
          onPressed: () {
            ref.read(setPriceProvider.notifier).clear();
            context.pop();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: StateWrapper(
          onSuccess: () {
            ref.read(priceProvider.notifier).clearSetPrices(state.priceModels);
            context.pop();
          },
          stateType: state.stateType,
          errorChild: Icon(Icons.error, color: Colors.red),
          child: Text('Установить цены'),
        ),
        icon: Icon(Icons.check),
        onPressed: () {
          ref.read(setPriceProvider.notifier).postPrices();
        },
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(8.0),
        separatorBuilder: (context, index) => Divider(),
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          final priceItem = state.items[index];
          return SetPriceTile(
            priceModel: priceItem.priceModel,
            onDelete: () {
              ref.read(setPriceProvider.notifier).deletePriceItem(priceItem);
            },
          );
        },
      ),
    );
  }
}
