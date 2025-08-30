class StockModel {
  final String productName;

  final String unitName;
  final double stock;
  final double oldPrice; // e.g. "Warehouse A"

  StockModel({
    required this.productName,
    required this.unitName,
    required this.stock,
    required this.oldPrice,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      productName: json['productName'],
      unitName: json['unitName'],
      stock: (json['stock'] ?? 0).toDouble(),
      oldPrice: (json['oldPrice'] ?? 0).toDouble(),
    );
  }
}
