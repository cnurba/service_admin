import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/products/domain/models/my_product_model.dart';

class MyProductDto extends Equatable {
  final String id;
  final String name;
  final String description;
  final String categoryId;
  final String categoryName;
  final String brandId;
  final String brandName;
  final String branchId;
  final String branchName;
  final double price;
  final String unit;
  final double oldPrice;
  final double stock;
  final String sku;
  final bool isActive;
  final bool isFeatured;
  final String createdAt;
  final String updatedAt;
  final List<dynamic> attributes;
  final List<String> imageUrls;

  const MyProductDto({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.categoryName,
    required this.brandId,
    required this.brandName,
    required this.branchId,
    required this.branchName,
    required this.price,
    required this.unit,
    required this.oldPrice,
    required this.stock,
    required this.sku,
    required this.isActive,
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
    required this.attributes,
    required this.imageUrls,
  });

  /// From JSON
  factory MyProductDto.fromJson(Map<String, dynamic> json) {
    return MyProductDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['categoryId'] ?? '',
      categoryName: json['categoryName'] ?? '',
      brandId: json['brandId'] ?? '',
      brandName: json['brandName'] ?? '',
      branchId: json['branchId'] ?? '',
      branchName: json['branchName'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      unit: json['unit'] ?? '',
      oldPrice: (json['oldPrice'] ?? 0).toDouble(),
      stock: (json['stock'] ?? 0).toDouble(),
      sku: json['sku'] ?? '',
      isActive: json['isActive'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      attributes: (json['attributes'] as List?) ?? [],
      imageUrls:
          (json['imageUrls'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  /// To Domain Model
  MyProductModel toMyProduct() {
    return MyProductModel(
      id: id,
      name: name,
      description: description,
      categoryId: categoryId,
      categoryName: categoryName,
      brandId: brandId,
      brandName: brandName,
      branchId: branchId,
      branchName: branchName,
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
  ];
}
