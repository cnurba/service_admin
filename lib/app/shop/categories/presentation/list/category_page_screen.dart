import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/categories/application/category_future_provider.dart';
import 'package:service_admin/app/shop/categories/presentation/widgets/category_tile.dart';

class CategoryPageScreen extends ConsumerWidget {
  const CategoryPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(categoryFutureProvider);
    return resultAsync.when(
      data: (categories) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(8.0),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            log(
              "Loading image for category ${category.name}, URL: ${category.imageUrl}",
            );
            return CategoryTile(category: category);
          },
        );
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
