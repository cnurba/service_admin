import 'package:equatable/equatable.dart';
import 'package:service_admin/core/http/server_address.dart';

class ProductDetailModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String categoryId;
  final String categoryName;
  final String brandId;
  final String brandName;
  final String branchId;
  final String branchName;
  final bool isActive;
  final bool isFeatured;
  final List<String> imageUrls;
  final List<ProductAttributeModel> attributes;

  const ProductDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.categoryName,
    required this.brandId,
    required this.brandName,
    required this.branchId,
    required this.branchName,
    required this.isActive,
    required this.isFeatured,
    required this.imageUrls,
    required this.attributes,
  });

  String get imagePath {
    return imageUrls.isNotEmpty
        ? "${ServerAddress().imageUrl}$imageUrls"
        : 'https://via.placeholder.com/150';
  }

  /// ✅ From API JSON
  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['uuid'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['categoryId'] ?? '',
      categoryName: json['categoryName'] ?? '',
      brandId: json['brandId'] ?? '',
      brandName: json['brandName'] ?? '',
      branchId: json['branchId'] ?? '',
      branchName: json['branchName'] ?? '',
      isActive: json['isActive'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      imageUrls:
          (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      attributes:
          (json['attributes'] as List<dynamic>?)
              ?.map((e) => ProductAttributeModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    categoryId,
    categoryName,
    brandId,
    brandName,
    branchId,
    branchName,
    isActive,
    isFeatured,
    imageUrls,
    attributes,
  ];
}

class ProductAttributeModel extends Equatable {
  final String name;
  final String attribute;
  final String attributeValue;
  final double stock;
  final double price;

  const ProductAttributeModel({
    required this.name,
    required this.attribute,
    required this.attributeValue,
    required this.stock,
    required this.price,
  });

  factory ProductAttributeModel.fromJson(Map<String, dynamic> json) {
    return ProductAttributeModel(
      name: json['name'] ?? '',
      attribute: json['attribute'] ?? '',
      attributeValue: json['attributeValue'] ?? '',
      stock: (json['stock'] ?? 0).toDouble(),
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  @override
  List<Object?> get props => [name, attribute, attributeValue, stock, price];
}
