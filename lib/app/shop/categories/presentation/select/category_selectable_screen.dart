import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/categories/application/category_future_provider.dart';
import 'package:service_admin/core/presentation/indicators/loader.dart';

class CategorySelectableScreen extends StatelessWidget {
  const CategorySelectableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выберите категорию')),
      body: Consumer(
        builder: (context, ref, child) {
          final resultAsync = ref.watch(categoryFutureProvider);
          return resultAsync.when(
            data: (categories) {
              if (categories.isEmpty) {
                return const Center(child: Text('Пустой список брендов'));
              }
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return ListTile(
                    title: Text(category.name),
                    onTap: () {
                      Navigator.pop(context, category);
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
