import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/data/shop_items_data.dart';
import 'package:service_admin/app/shop/widgets/shop_item_card.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Магазин'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.circle_notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: ShopItems.length,
          itemBuilder: (context, index) {
            return ShopItemCard(item: ShopItems[index]);
          },
        ),
      ),
    );
  }
}
