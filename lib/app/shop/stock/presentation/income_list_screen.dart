import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/stock/application/basket_provider/basket_provider.dart';
import 'package:service_admin/app/shop/stock/application/stocs/income_future_provider.dart';
import 'package:service_admin/app/shop/stock/presentation/basket_screen.dart';

import 'package:service_admin/app/shop/stock/presentation/widgets/stock_tile.dart';
import 'package:service_admin/core/extansions/router_extension.dart';

class IncomeListScreen extends ConsumerStatefulWidget {
  const IncomeListScreen({super.key, required this.type});

  final String type;

  @override
  ConsumerState<IncomeListScreen> createState() => _IncomeListScreenState();
}

class _IncomeListScreenState extends ConsumerState<IncomeListScreen> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(basketProvider.notifier).setType(widget.type);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final resultAsync = ref.watch(incomeFutureProvider);
    final basketItems = ref.watch(basketProvider).items;
    return Scaffold(
      appBar: AppBar(title: const Text('Выберите товар')),
      body: resultAsync.when(
        data: (incomes) {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: incomes.length,
            itemBuilder: (context, index) {
              final item = incomes[index];
              return StockTile(
                stock: item,
                isSelected: false,
                onSelect: () {
                  ref.read(basketProvider.notifier).setItem(item);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: basketItems.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                context.push(BasketScreen());
              }, //_showSelectedItems(context),
              label: Row(
                children: [
                  const Icon(Icons.shopping_basket),
                  const SizedBox(width: 8),
                  Text("${basketItems.length} выбрано"),
                ],
              ),
            )
          : null,
    );
  }

  //
  // void _showSelectedItems(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setModalState) {
  //           return SelectedItemsBottomSheet(
  //             selectedItems: selectedItems,
  //             onDelete: (index) {
  //               setState(() {
  //                 selectedItems.removeAt(index);
  //               });
  //               setModalState(() {});
  //             },
  //             onConfirm: () {
  //               Navigator.pop(context);
  //               ScaffoldMessenger.of(
  //                 context,
  //               ).showSnackBar(const SnackBar(content: Text('Оформлено')));
  //             },
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
