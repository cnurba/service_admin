import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/products_by_product_id_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productByProductIdFutureProvider(productId));

    return Scaffold(
      appBar: AppBar(title: const Text("Детали о продукте")),
      body: productAsync.when(
        data: (product) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if (product.id.isNotEmpty)
                //   Image.network(product.id.),
                const SizedBox(height: 16),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(product.description),
                const SizedBox(height: 8),
                Text("Price: \$${product.price}"),
                // Text("Stock: ${product.stock}"),
                Text("Unit: ${product.unit}"),
              ],
            ),
          );
        },
        error: (error, _) => Center(child: Text("Error: $error")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
