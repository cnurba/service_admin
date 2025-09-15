import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/my_product_future_provider.dart';
import 'package:service_admin/app/shop/products/presentation/list/product_list_screen.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/new/new_product_screen.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/product_detail_screen.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/widgets/product_tile.dart';
import 'package:service_admin/core/extansions/router_extension.dart';
import 'package:service_admin/core/presentation/slidable/expandable_fab.dart';

class MyProductsList extends ConsumerWidget {
  const MyProductsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(myProductFutureProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Мои товары')),
      floatingActionButton: ExpandableFab(
        distance: 60,
        children: [
          ActionFab(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.push(NewProductScreen());
            },
          ),
          ActionFab(
            icon: const Icon(Icons.edit_attributes),
            onPressed: () {
              context.push(ProductListScreen());
            },
          ),
        ],
      ),
      body: resultAsync.when(
        data: (myProducts) {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            physics: BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 4,
              childAspectRatio: 0.75,
            ),
            itemCount: myProducts.length,
            itemBuilder: (context, index) {
              final product = myProducts[index];
              return ProductTile(
                product: product,
                onTap: () {
                  context.push(ProductDetailScreen(productId: product.id));
                },
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
