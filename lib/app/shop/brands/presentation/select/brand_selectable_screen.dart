import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/brands/application/brand_future_provider.dart';
import 'package:service_admin/core/presentation/indicators/loader.dart';

class BrandSelectableScreen extends StatelessWidget {
  const BrandSelectableScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите бренд'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final resultAsync = ref.watch(brandFutureProvider);
          return resultAsync.when(
            data: (brands) {
              if (brands.isEmpty) {
                return const Center(child: Text('Пустой список брендов'));
              }
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: brands.length,
                itemBuilder: (context, index) {
                  final brand = brands[index];
                  return ListTile(
                    title: Text(brand.name),
                    onTap: () {
                      Navigator.pop(context, brand);
                    },
                  );
                },
              );
            },
            loading: () => const Loader(),
            error: (error, stack) => Center(child: Text('Ошибка: $error')),
          );
        },
      ),
    );
  }
}
