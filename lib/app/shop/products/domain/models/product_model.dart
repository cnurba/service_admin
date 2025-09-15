import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String categoryId;
  final String categoryName;
  final String brandId;
  final String brandName;
  final String branchId;
  final String branchName;
  final String imageUrl;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.categoryName,
    required this.brandId,
    required this.brandName,
    required this.branchId,
    required this.branchName,
    required this.imageUrl,
  });

  factory ProductModel.empty() {
    return const ProductModel(
      id: '',
      name: '',
      description: '',
      categoryId: '',
      categoryName: '',
      brandId: '',
      brandName: '',
      branchId: '',
      branchName: '',
      imageUrl: '',
    );
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? categoryId,
    String? categoryName,
    String? brandId,
    String? brandName,
    String? branchId,
    String? branchName,
    String? imageUrl,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      brandId: brandId ?? this.brandId,
      brandName: brandName ?? this.brandName,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? "",
      description: json['description'] ?? '',
      categoryId: json['categoryId'] ?? '',
      categoryName: json['categoryName'] ?? '',
      brandId: json['brandId'] ?? '',
      brandName: json['brandName'] ?? '',
      branchId: json['branchId'] ?? '',
      branchName: json['branchName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    categoryId,
    categoryName,
    branchId,
    brandName,
    branchId,
    brandName,
    imageUrl,
  ];
}
