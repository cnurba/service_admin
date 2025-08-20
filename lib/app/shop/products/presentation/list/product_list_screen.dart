import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/branch_product_add/branch_product_add_provider.dart';
import 'package:service_admin/app/shop/products/application/application/my_product_future_provider.dart';
import 'package:service_admin/app/shop/products/application/application/product_future_provider.dart';
import 'package:service_admin/app/shop/products/presentation/list/widgets/product_check_tile.dart';
import 'package:service_admin/core/presentation/messenger/centered_snack.dart';

import '../../application/application/branch_product_add/branch_product_post_provider.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  void post(WidgetRef ref, BuildContext context) async {
    /// post data using branchProductPostProvider - wich is a future povider
    final List<String> ids = ref.read(branchProductAddProvider);
    final result1 = await ref.read(branchProductPostProvider(ids).future);
    if (result1) {
      ref.read(branchProductAddProvider.notifier).clear();
      showCenteredSnackWithAction(
        context: context,
        message: 'Товары успешно добавлены в ваш магазин',
        onTap: () {
          Navigator.of(context).pop();
        },
      );

      ref.refresh(myProductFutureProvider);
      return;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(productFutureProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Товары")),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Visibility(
        visible: ref.watch(branchProductAddProvider).isNotEmpty,
        child: FloatingActionButton.extended(
          onPressed: () {
            post(ref, context);
          },
          label: const Text("Добавить"),
          icon: Icon(Icons.check),
        ),
      ),
      body: resultAsync.when(
        data: (products) {
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCheckTile(
                product: product,
                isChecked: ref.watch(
                  branchProductAddProvider.select(
                    (state) => state.contains(product.id.toString()),
                  ),
                ),
                onChanged: (bool? added) {
                  ref
                      .read(branchProductAddProvider.notifier)
                      .addOrDelete(product.id.toString(), added ?? false);
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
