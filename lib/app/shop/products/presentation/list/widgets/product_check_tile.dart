import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/products/domain/models/product_model.dart';

class ProductCheckTile extends StatelessWidget {
  const ProductCheckTile({
    super.key,
    required this.product,
    this.isChecked = false,
    this.onChanged,
  });

  final ProductModel product;
  final bool isChecked;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: isChecked,
      title: Text(product.name),
      subtitle: Text("${product.categoryName}"),
      onChanged: onChanged,
    );
  }
}
