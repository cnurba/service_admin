import 'package:equatable/equatable.dart';

class MyProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String categoryId;
  final String categoryName;
  final String brandId;
  final String brandName;
  final String branchId;
  final String branchName;

  const MyProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.categoryName,
    required this.brandId,
    required this.brandName,
    required this.branchId,
    required this.branchName,
  });

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
  ];
}
