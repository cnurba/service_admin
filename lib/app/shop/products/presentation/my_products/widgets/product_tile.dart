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
    return ListTile(
      title: Text(product.name),
      subtitle: Text('Категория: ${product.categoryName} -Бренд: ${product.branchName}'),
      onTap: onTap,
    );
  }
}
