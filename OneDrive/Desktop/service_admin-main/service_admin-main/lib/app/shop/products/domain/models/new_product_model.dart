import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/brands/domain/models/brand_model.dart';
import 'package:service_admin/app/shop/categories/domain/models/category_model.dart';

class NewProductModel extends Equatable{
  final String id;
  final String name;
  final String description;
  final CategoryModel category;
  final BrandModel brand;
  final String unit;
  final bool isActive;
  final bool isFeatured;
  final bool hasAttributes;

  const NewProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
    required this.unit,
    required this.isActive,
    required this.isFeatured,
    required this.hasAttributes,
  });

  factory NewProductModel.empty() {
    return NewProductModel(
      id: '',
      name: '',
      description: '',
      category: CategoryModel.empty(),
      brand: BrandModel.empty(),
      unit: '',
      isActive: true,
      isFeatured: false,
      hasAttributes: false,
    );
  }

  copyWith({
    String? id,
    String? name,
    String? description,
    CategoryModel? category,
    BrandModel? brand,
    String? unit,
    bool? isActive,
    bool? isFeatured,
    bool? hasAttributes,
  }) {
    return NewProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      unit: unit ?? this.unit,
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
      hasAttributes: hasAttributes ?? this.hasAttributes,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}