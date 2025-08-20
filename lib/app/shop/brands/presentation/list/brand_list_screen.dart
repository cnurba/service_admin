import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/brands/application/brand_future_provider.dart';
import 'package:service_admin/app/shop/brands/application/brand_image/brand_future_provider.dart';
import 'package:service_admin/app/shop/brands/presentation/new/brand_new_screen.dart';

class BrandListScreen extends ConsumerWidget {
  const BrandListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(brandFutureProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brands'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.refresh(brandFutureProvider);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          log("Add new brand button pressed");
          final (image, imagePath) = await ref
              .read(imageRepositoryProvider)
              .pickImageFromGallery("Brand");

          if (image != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return BrandNewScreen(image: image, imagePath: imagePath);
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
        data: (brands) {
          return ListView.builder(
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return ListTile(
                title: Text(brand.name),
                subtitle: Text('ID: ${brand.id}'),
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
