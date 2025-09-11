import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/stock/domain/models/stock.model.dart';
import 'package:service_admin/core/presentation/slidable/app_slidable.dart';

class SelectedItemsBottomSheet extends StatelessWidget {
  final List<IncomeModel> selectedItems;
  final Function(int) onDelete;
  final VoidCallback? onConfirm;

  const SelectedItemsBottomSheet({
    super.key,
    required this.selectedItems,
    required this.onDelete,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Выбранные товары",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: selectedItems.length,
                      itemBuilder: (context, index) {
                        final item = selectedItems[index];
                        return AppSlidable(
                          id: item.productUuid,
                          onDelete: (_) {
                            onDelete(index);
                            if (selectedItems.isEmpty) {
                              Navigator.pop(context);
                            }
                          },
                          child: Card(
                            color: Colors.blueGrey.shade50,
                            child: ListTile(
                              title: Text(item.productName),
                              subtitle: Text(item.productPropertyName),
                              trailing: Text("${item.stock} ${item.unitName}"),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            );
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton.extended(
            onPressed: onConfirm,
            icon: const Icon(Icons.done),
            label: const Text("Оформить"),
            backgroundColor: Colors.blue,
          ),
        ),
      ],
    );
  }
}
