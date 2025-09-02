import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/categories/application/category_future_provider.dart';
import 'package:service_admin/app/shop/categories/application/category_image/image_future_provider.dart';
import 'package:service_admin/app/shop/categories/presentation/new/category_new_screen.dart';
import 'package:service_admin/core/http/server_address.dart';

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
              log(
                "Loading image for category ${category.name}, URL: ${category.imageUrl}",
              );
              return Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      category.imageUrl != null && category.imageUrl.isNotEmpty
                          ? Image.network(
                              ServerAddress().imageUrl + category.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                log(
                                  "Image load error for ${category.imageUrl}: $error",
                                );
                                return const Icon(Icons.error, size: 50);
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const CircularProgressIndicator();
                                  },
                            )
                          : const Icon(Icons.image_not_supported, size: 50),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'ID: ${category.id}, ${category.imageUrl}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
