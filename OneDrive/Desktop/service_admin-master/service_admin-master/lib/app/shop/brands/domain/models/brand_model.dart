import 'package:equatable/equatable.dart';

class BrandModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String logoUrl;
  final bool isActive;
  final int sortOrder;

  const BrandModel({
    required this.id,
    required this.name,
    required this.description,
    required this.logoUrl,
    required this.isActive,
    required this.sortOrder,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    logoUrl,
    isActive,
    sortOrder,
  ];
}
