import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/my_product_future_provider.dart';
import 'package:service_admin/app/shop/products/presentation/list/product_list_screen.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/product_detail_screen.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/widgets/product_tile.dart';
import 'package:service_admin/core/presentation/slidable/app_slidable.dart';

class MyProductsList extends ConsumerWidget {
  const MyProductsList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(myProductFutureProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Мои Товары')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const ProductListScreen(), // ✅ works now
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: resultAsync.when(
        data: (myProducts) {
          return ListView.builder(
            itemCount: myProducts.length,
            itemBuilder: (context, index) {
              final product = myProducts[index];
              return AppSlidable(
                id: product.id.toString(),
                onDelete: (ctx) {
                  log('Deleting product: ${product.name}');
                },
                child: ProductTile(
                  product: product,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(
                          productId: product.id.toString(),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),

    );
  }
}
