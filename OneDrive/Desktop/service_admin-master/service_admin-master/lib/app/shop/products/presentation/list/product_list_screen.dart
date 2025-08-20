import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/product_future_provider.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(productFutureProvider);
    return Scaffold(
      body: resultAsync.when(
        data: (products) {
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('ID: ${product.id}'),
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
