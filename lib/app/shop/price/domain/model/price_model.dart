class PriceModel {
  final String productName;
  final String productUuid;
  final String productPropertyName;
  final String productPropertyUuid;
  final String unitName;
  final double stock;
  final int oldPrice;

  PriceModel({
    required this.productName,
    required this.productUuid,
    required this.productPropertyName,
    required this.productPropertyUuid,
    required this.unitName,
    required this.stock,
    required this.oldPrice,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      productName: json['productName'],
      productUuid: json['productUuid'],
      productPropertyName: json['productPropertyName'],
      productPropertyUuid: json['productPropertyUuid'],
      unitName: json['unitName'],
      stock: (json['stock'] ?? 0).toDouble(),
      oldPrice: (json['oldPrice'] ?? 0),
    );
  }
}
