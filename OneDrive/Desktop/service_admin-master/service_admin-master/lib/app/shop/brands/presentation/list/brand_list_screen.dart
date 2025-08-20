import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/brands/application/brand_future_provider.dart';

class BrandListScreen extends ConsumerWidget {
  const BrandListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(brandFutureProvider);
    return Scaffold(
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
