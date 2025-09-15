import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/categories/domain/models/category_model.dart';
import 'package:service_admin/core/presentation/image/app_image_container.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImageContainer(
              image: category.imageUrl,
              width: 50,
              height: 50,
              borderRadius: 8.0,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0,
                  offset: Offset(0, 2),
                ),
              ],
              placeholder: const Icon(Icons.image, size: 50),
              errorWidget: const Icon(Icons.error, size: 50),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category.name),
                  Text(
                    category.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
