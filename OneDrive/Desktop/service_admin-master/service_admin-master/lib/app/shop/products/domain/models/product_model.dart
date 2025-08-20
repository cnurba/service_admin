import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isActive;
  final double price;
  final String unit;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isActive,
    required this.price,
    required this.unit,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    imageUrl,
    isActive,
    price,
    unit,
  ];
}
