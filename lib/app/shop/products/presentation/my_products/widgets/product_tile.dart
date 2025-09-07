import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/products/domain/models/product_model.dart';

/// A tile widget to display product information in a list
/// It shows the product name, category, and brand.
/// Tapping on the tile can trigger an optional callback.
class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product, this.onTap});
  final ProductModel product;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: ListTile(
        title: Text(product.name, style: TextStyle(fontSize: 16)),
        subtitle: Text(
          'Категория: ${product.categoryName}\nБренд: ${product.branchName}\n${product.description}',
        ),

        onTap: onTap,
      ),
    );
  }
}
