import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/categories/domain/models/category_model.dart';

class CategoryDto extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String createdAt;
  final String updatedAt;
  final bool isActive;
  final int sortOrder;

  const CategoryDto({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.sortOrder,
  });
  /// From json
  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      id: json['id'] ?? "",
      name: json['name'] ??'',
      description: json['description'] ??'',
      imageUrl: json['imageUrl']??'',
      createdAt: json['createdAt'] ??'',
      updatedAt: json['updatedAt'] ??'',
      isActive: json['isActive'] ?? false,
      sortOrder: json['sortOrder'] ?? 0,
    );
  }

  /// Transform to the Category model
  CategoryModel toCategory() {
    return CategoryModel(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      isActive: isActive,
      sortOrder: sortOrder,
    );
  }

  /// Create a DTO from a Category mode

 factory CategoryDto.fromCategory(CategoryModel category) {
    return CategoryDto(
      id: category.id,
      name: category.name,
      description: category.description,
      imageUrl: category.imageUrl,
      isActive: category.isActive,
      sortOrder: category.sortOrder,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: "",
    );
  }

  /// Transform to json
  Map<String, dynamic>toJson () {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isActive': isActive,
      'sortOrder': sortOrder,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    imageUrl,
    isActive,
    sortOrder,
    createdAt,
    updatedAt,
  ];
}
