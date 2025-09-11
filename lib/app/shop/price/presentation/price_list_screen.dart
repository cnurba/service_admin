import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/price/application/set_price_provider/set_price_controller.dart';
import 'package:service_admin/app/shop/price/presentation/set_price_screen.dart';
import 'package:service_admin/app/shop/price/presentation/widget/price_page_screen.dart';
import 'package:service_admin/core/extansions/router_extension.dart';

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
      appBar: AppBar(title: const Text("Цены")),
      body: PricePageScreen(),
      floatingActionButton: Builder(
        builder: (context) {
          final _newPrices = ref.watch(setPriceProvider);
          return FloatingActionButton.extended(
            onPressed: () {
              context.push(SetPriceScreen());
            },
            label: Text(
              "Выбрано ${_newPrices.items.length} строк(а)\nУстановить новые цены",
              textAlign: TextAlign.center,
            ),
            icon: const Icon(Icons.check),
            backgroundColor: Colors.blue[700],
          );
        },
      ),
    );
  }
}
