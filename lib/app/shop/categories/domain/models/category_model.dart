import 'package:equatable/equatable.dart';
import 'package:service_admin/core/http/server_address.dart';
/// Represents a category in the shop.
/// Contains properties such as id, name, description, imageUrl, isActive, and sortOrder.
/// Provides methods to create an empty instance and to copy with modified properties.
class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isActive;
  final int sortOrder;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isActive,
     required this.sortOrder,
  });

  String get imagePath {
    return imageUrl.isNotEmpty ? "${ServerAddress().imageUrl}$imageUrl" : 'https://via.placeholder.com/150';
  }

  factory CategoryModel.empty() {
    return const CategoryModel(
      id: '',
      name: '',
      description: '',
      imageUrl: '',
      isActive: false,
      sortOrder: 0,
    );
  }

  /// Copy with method to create a new instance with modified properties.
  CategoryModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    bool? isActive,
    int? sortOrder,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }


  @override
  List<Object?> get props => [
    id,
    name,
    description,
    imageUrl,
    isActive,
    sortOrder,
  ];
}
