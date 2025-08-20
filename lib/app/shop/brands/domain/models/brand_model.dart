import 'package:equatable/equatable.dart';

class BrandModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final bool isActive;
  final String logoUrl;

  const BrandModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.logoUrl,
  });

  /// Copy with method to create a new instance with modified properties.
  BrandModel copyWith({
    String? id,
    String? name,
    String? description,
    bool? isActive,
    String? logoUrl,
  }) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      logoUrl: logoUrl ?? this.logoUrl,
      isActive: isActive ?? this.isActive,
    );
  }

  factory BrandModel.empty() {
    return const BrandModel(
      id: '',
      name: '',
      description: '',
      isActive: false,
      logoUrl: '',
    );
  }

  @override
  List<Object?> get props => [id, name, description, logoUrl, isActive];
}
