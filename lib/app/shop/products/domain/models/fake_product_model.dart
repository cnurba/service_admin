class FakeProductModel {
  final String uuid;
  final String name;
  final String description;
  final String categoryName;
  final String brandName;
  final String branchName;
  final List<String> imageUrls;
  final List<Map<String, dynamic>> attributes;

  FakeProductModel({
    required this.uuid,
    required this.name,
    required this.description,
    required this.categoryName,
    required this.brandName,
    required this.branchName,
    required this.imageUrls,
    required this.attributes,
  });

  factory FakeProductModel.fromJson(Map<String, dynamic> json) {
    return FakeProductModel(
      uuid: json["uuid"],
      name: json["name"],
      description: json["description"],
      categoryName: json["categoryName"],
      brandName: json["brandName"],
      branchName: json["branchName"],
      imageUrls: List<String>.from(json["imageUrls"]),
      attributes: List<Map<String, dynamic>>.from(json["attributes"]),
    );
  }
}
