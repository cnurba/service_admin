class PriceModel {
  final String productName;
  final String productUuid;
  final String unitName;
  final double stock;
  final int oldPrice;
  final int wholesalePrice;
  final int retailPrice;

  PriceModel({
    required this.productName,
    required this.productUuid,
    required this.unitName,
    required this.stock,
    required this.oldPrice,
    this.wholesalePrice = 0,
    this.retailPrice = 0,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      productName: json['productName'],
      productUuid: json['productUuid'],
      unitName: json['unitName'],
      stock: (json['stock'] ?? 0).toDouble(),
      oldPrice: (json['oldPrice'] ?? 0),
      wholesalePrice: (json['wholesalePrice'] ?? 0),
      retailPrice: (json['retailPrice'] ?? 0),
    );
  }
}
