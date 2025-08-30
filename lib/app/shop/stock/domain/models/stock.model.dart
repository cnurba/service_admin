import 'package:service_admin/app/shop/products/domain/models/product_model.dart';

class StockModel {
  final ProductModel productModel;
  final double stock;
  final double price;
  final double amount;

  const StockModel({
    required this.productModel,
    required this.stock,
    required this.price,
    required this.amount,
  });


  // e.g. "Warehouse A"
}
