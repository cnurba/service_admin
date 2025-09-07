import 'package:flutter/material.dart';

class ShopTile extends StatelessWidget {
  const ShopTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ListTile(
        title: const Text('Категории'),
        leading: const Icon(Icons.shopping_cart),
        onTap: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(builder: (context) => CategoryListScreen()),
          // );
        },
      ),
    );
  }
}
