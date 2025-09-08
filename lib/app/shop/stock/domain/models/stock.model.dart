import 'package:equatable/equatable.dart';

class StockModel extends Equatable {
  final String productName;
  final String productUuid;
  final String productPropertyName;
  final String productPropertyUuid;
  final String unitName;
  final double stock;

  const StockModel({
    required this.productName,
    required this.productUuid,
    required this.productPropertyName,
    required this.productPropertyUuid,
    required this.unitName,
    required this.stock,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      productName: json['productName'],
      productUuid: json['productUuid'],
      productPropertyName: json['productPropertyName'],
      productPropertyUuid: json['productPropertyUuid'],
      unitName: json['unitName'],
      stock: (json['stock'] ?? 0).toDouble(),
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
  ];


}
