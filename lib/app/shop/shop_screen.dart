import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/data/shop_items_data.dart';
import 'package:service_admin/app/shop/widgets/search_delagate.dart';
import 'package:service_admin/app/shop/widgets/shop_item_card.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firstSection = ShopItems.take(4).toList();
    final secondSection = ShopItems.skip(4).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Магазин',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: GenericSearchDelegate(
                  items: ShopItems,
                  getLabel: (item) => item.title,
                  buildResultItem: (item) => ListTile(title: Text(item.title)),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.circle_notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Справочники',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 14),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: firstSection.length,
                itemBuilder: (context, index) {
                  return ShopItemCard(item: firstSection[index]);
                },
              ),
              const SizedBox(height: 14),
              const Text(
                'Цены и остатки',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 14),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: secondSection.length,
                itemBuilder: (context, index) =>
                    ShopItemCard(item: secondSection[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
