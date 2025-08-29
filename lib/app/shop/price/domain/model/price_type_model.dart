class PriceTypeModel {
  final String name;
  final String uuid;

  PriceTypeModel({required this.name, required this.uuid});

  factory PriceTypeModel.fromJson(Map<String, dynamic> json) {
    return PriceTypeModel(name: json['name'] ?? '', uuid: json['uuid'] ?? '');
  }
}
