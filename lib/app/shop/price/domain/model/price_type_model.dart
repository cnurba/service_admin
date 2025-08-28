class PriceTypeModel {
  final String name;
  final String uuid;
  final int wholesalePrice;
  final int retailPrice;

  PriceTypeModel({
    required this.name,
    required this.uuid,
    this.wholesalePrice = 0,
    this.retailPrice = 0,
  });

  factory PriceTypeModel.fromJson(Map<String, dynamic> json) {
    return PriceTypeModel(
      name: json['name'] ?? '',
      uuid: json['uuid'] ?? '',
      wholesalePrice: json['wholesalePrice'] ?? 0, // initialize correctly
      retailPrice: json['retailPrice'] ?? 0, // initialize correctly
    );
  }
}
