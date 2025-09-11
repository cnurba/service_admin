import 'package:equatable/equatable.dart';

class IncomeModel extends Equatable {
  final String productName;
  final String productUuid;
  final String productPropertyName;
  final String productPropertyUuid;
  final String unitName;
  final double stock;

  const IncomeModel({
    required this.productName,
    required this.productUuid,
    required this.productPropertyName,
    required this.productPropertyUuid,
    required this.unitName,
    required this.stock,
  });

  factory IncomeModel.fromJson(Map<String, dynamic> json) {
    return IncomeModel(
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
