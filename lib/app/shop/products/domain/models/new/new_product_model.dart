import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/brands/domain/models/brand_model.dart';
import 'package:service_admin/app/shop/brands/infrastructure/dtos/brand_dto.dart';
import 'package:service_admin/app/shop/categories/domain/models/category_model.dart';
import 'package:service_admin/app/shop/categories/infrastructure/dtos/category_dto.dart';
import 'package:service_admin/app/shop/units/domain/unit_model.dart';

class NewProductModel extends Equatable{
  final String id;
  final String name;
  final String description;
  final CategoryModel category;
  final BrandModel brand;
  final UnitModel unit;
  final String sku;
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
    required this.sku,
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
      unit: UnitModel.empty(),
      sku: '',
      isActive: true,
      isFeatured: false,
      hasAttributes: false,
    );
  }

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': CategoryDto.fromCategory(category).toJson(),
      'brand': BrandDto.fromBrand(brand).toJson(),
      'unit': unit.toJson(unit),
      'sku': sku,
      'is_active': isActive,
      'is_featured': isFeatured,
      'has_attributes': hasAttributes,
    };
  }

  NewProductModel copyWith({
    String? id,
    String? name,
    String? description,
    CategoryModel? category,
    BrandModel? brand,
    UnitModel? unit,
    String? sku,
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
      sku: sku ?? this.sku,
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
      hasAttributes: hasAttributes ?? this.hasAttributes,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    category,
    brand,
    unit,
    sku,
    isActive,
    isFeatured,
    hasAttributes,
  ];
}
