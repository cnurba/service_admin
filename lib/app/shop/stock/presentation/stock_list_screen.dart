import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/stock/domain/models/stock.model.dart';
import 'package:service_admin/app/shop/stock/presentation/widgets/bottom_sheet.dart';
import 'package:service_admin/app/shop/stock/presentation/widgets/stock_tile.dart';

class StockListScreen extends ConsumerStatefulWidget {
  const StockListScreen({super.key});

  @override
  ConsumerState<StockListScreen> createState() => _StockListScreenState();
}

class _StockListScreenState extends ConsumerState<StockListScreen> {
  final List<IncomeModel> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Остатки')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          final item = IncomeModel(
            productName: "Product $index",
            productPropertyName: "Property $index",
            productPropertyUuid: "uuid-$index",
            productUuid: "prod-uuid-$index",
            stock: 255,
            unitName: "шт",
          );

          final isSelected = selectedItems.any(
            (selected) => selected.productUuid == item.productUuid,
          );

          return StockTile(
            stock: item,
            isSelected: isSelected,
            onSelect: () {
              if (!isSelected) {
                setState(() {
                  selectedItems.add(item);
                });
              }
            },
          );
        },
      ),
      floatingActionButton: selectedItems.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () => _showSelectedItems(context),
              label: Row(
                children: [
                  const Icon(Icons.shopping_basket),
                  const SizedBox(width: 8),
                  Text("${selectedItems.length} выбрано"),
                ],
              ),
              backgroundColor: Colors.lightBlue,
            )
          : null,
    );
  }

  void _showSelectedItems(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SelectedItemsBottomSheet(
              selectedItems: selectedItems,
              onDelete: (index) {
                setState(() {
                  selectedItems.removeAt(index);
                });
                setModalState(() {});
              },
              onConfirm: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Оформлено')));
              },
            );
          },
        );
      },
    );
  }
}
