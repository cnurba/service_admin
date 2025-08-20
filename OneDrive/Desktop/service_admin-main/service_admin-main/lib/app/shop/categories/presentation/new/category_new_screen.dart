import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/categories/application/new_category/provider.dart';
import 'package:service_admin/core/presentation/buttons/app_button.dart';

class CategoryNewScreen extends ConsumerWidget {
  const CategoryNewScreen({
    super.key,
    required this.imagePath,
    required this.image,
  });

  final String imagePath;
  final File image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Новая категория')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display the selected image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(image),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) {
                ref.read(categoryProvider.notifier).setName(value);
              },
              decoration: InputDecoration(
                labelText: 'Название категории',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) {
                ref.read(categoryProvider.notifier).setDescription(value);
              },
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Описание категории',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            AppButton(
              title: "Сохранить",
              onPressed: () {
                ref.read(categoryProvider.notifier).setImagePath(imagePath);
                ref.read(categoryProvider.notifier).createCategory();
              },
            ),
          ],
        ),
      ),
    );
  }
}
