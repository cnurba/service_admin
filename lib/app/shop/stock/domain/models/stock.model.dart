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
  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      productModel: json['productModel'],
      stock: (json['stock'] ?? 0).toDouble(),
      price: json['price'],
      amount: json['amount'],
    );
  }
}
