import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/categories/application/category_future_provider.dart';
import 'package:service_admin/app/shop/categories/application/category_image/image_future_provider.dart';
import 'package:service_admin/app/shop/categories/presentation/new/category_new_screen.dart';

class CategoryListScreen extends ConsumerWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(categoryFutureProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.refresh(categoryFutureProvider);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          log("Add new category button pressed");
          final (image, imagePath) = await ref
              .read(imageRepositoryProvider)
              .pickImageFromGallery("Category");

          if (image != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return CategoryNewScreen(image: image, imagePath: imagePath);
                },
              ),
            );
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('No image selected')));
          }
        },
        child: const Icon(Icons.add),
      ),
      body: resultAsync.when(
        data: (categories) {
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                title: Text(category.name),
                subtitle: Text('ID: ${category.id}'),
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
