import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/stock/domain/models/income_basket_model.dart';

class IncomeModel extends Equatable {
  final String productName;
  final String productUuid;
  final String productPropertyName;
  final String productPropertyUuid;
  final String unitName;
  final double stock;
  final double price;
  final String imageUrl;

  const IncomeModel({
    required this.productName,
    required this.productUuid,
    required this.productPropertyName,
    required this.productPropertyUuid,
    required this.unitName,
    required this.stock,
    this.price = 0,
    this.imageUrl = '',
  });

  IncomeBasketModel toIncomeBasketModel() {
    return IncomeBasketModel(
      incomeModel: this,
      price: price,
      stock: 0,
      amount: 0,
    );
  }

  factory IncomeModel.fromJson(Map<String, dynamic> json) {
    return IncomeModel(
      productName: json['productName'],
      productUuid: json['productUuid'],
      productPropertyName: json['productPropertyName'],
      productPropertyUuid: json['productPropertyUuid'],
      unitName: json['unitName'],
      stock: (json['stock'] ?? 0).toDouble(),
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  copyWith({
    String? productName,
    String? productUuid,
    String? productPropertyName,
    String? productPropertyUuid,
    String? unitName,
    double? stock,
    double? price,
    String? imageUrl,
  }) {
    return IncomeModel(
      productName: productName ?? this.productName,
      productUuid: productUuid ?? this.productUuid,
      productPropertyName: productPropertyName ?? this.productPropertyName,
      productPropertyUuid: productPropertyUuid ?? this.productPropertyUuid,
      unitName: unitName ?? this.unitName,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
    productName,
    productUuid,
    productPropertyName,
    productPropertyUuid,
    unitName,
    stock,
    price,
    imageUrl,
  ];
}
