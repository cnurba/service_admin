import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/brands/domain/models/brand_model.dart';

class BrandDto extends Equatable {
  final String id;
  final String name;
  final String description;
  final String logoUrl;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final String website;
  final String country;

  const BrandDto({
    required this.id,
    required this.name,
    required this.description,
    required this.logoUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.website,
    required this.country,
  });

  /// From json
  factory BrandDto.fromJson(Map<String, dynamic> json) {
    return BrandDto(
      id: json['id'] ?? "",
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      isActive: json['isActive'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      website: json['website'] ?? '',
      country: json['country'] ?? '',
    );
  }

  /// Transform to the Category model
  BrandModel toBrand() {
    return BrandModel(
      id: id,
      name: name,
      description: description,
      logoUrl: logoUrl,
      isActive: isActive,
    );
  }

  factory BrandDto.fromBrand(BrandModel brand) {
    return BrandDto(
      id: brand.id,
      name: brand.name,
      description: brand.description,
      isActive: brand.isActive,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: "",
      logoUrl: brand.logoUrl,
      website: '',
      country: '',
    );
  }

  /// Transform to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'logoUrl': logoUrl,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'website': website,
      'country': country,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    logoUrl,
    isActive,
    createdAt,
    updatedAt,
    website,
    country,
  ];
}
