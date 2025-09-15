import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/products/domain/models/product_model.dart';
import 'package:service_admin/core/presentation/image/app_image_container.dart';

/// A tile widget to display product information in a list
/// It shows the product name, category, and brand.
/// Tapping on the tile can trigger an optional callback.
class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product, this.onTap});

  final ProductModel product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        //margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImageContainer(
              image: product.imageUrl,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    product.categoryName,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.brandName,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            //ElevatedButton(onPressed: onTap, child: const Text('Подробнее')),
          ],
        ),
      ),
    );
  }
}
