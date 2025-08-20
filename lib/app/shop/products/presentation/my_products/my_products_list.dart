import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:service_admin/app/shop/products/application/application/my_product_future_provider.dart';
import 'package:service_admin/app/shop/products/presentation/list/product_list_screen.dart';

// Import your detail screen with alias to avoid confusion
import 'package:service_admin/app/shop/products/presentation/my_products/product_detail_screen.dart'
    as my;

class MyProductsList extends ConsumerWidget {
  const MyProductsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(myProductFutureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Мои Товары')),
      body: resultAsync.when(
        data: (myproducts) {
          return ListView.builder(
            itemCount: myproducts.length,
            itemBuilder: (context, index) {
              final myproduct = myproducts[index];
              return ListTile(
                title: Text(myproduct.name),
                subtitle: Text('ID: ${myproduct.id}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => my.ProductDetailScreen(
                        productId: myproduct.id.toString(), // ensure String
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
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
    );
  }
}
