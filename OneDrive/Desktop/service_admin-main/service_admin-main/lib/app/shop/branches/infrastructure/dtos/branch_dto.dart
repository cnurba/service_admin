import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/branches/domain/models/branch_model.dart';

class BranchDto extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final String address;
  final String phone;
  final String email;
  final String workingHours;
  final String location;
  final int rating;
  final int discountPercent;
  final int minOrderAmount;
  final bool isOpen;
  final String status;

  const BranchDto({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
    required this.phone,
    required this.email,
    required this.workingHours,
    required this.location,
    required this.rating,
    required this.discountPercent,
    required this.minOrderAmount,
    required this.isOpen,
    required this.status,
  });

  /// From json
  factory BranchDto.fromJson(Map<String, dynamic> json) {
    return BranchDto(
      id: json['id'] ?? "",
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      isActive: json['isActive'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      workingHours: json['workingHours'] ?? '',
      location: json['location'] ?? '',
      rating: json['rating'] ?? 0,
      discountPercent: json['discountPercent'] ?? 0,
      minOrderAmount: json['minOrderAmount'] ?? 0,
      isOpen: json['isOpen'] ?? false,
      status: json['status'] ?? '',
    );
  }

  /// Transform to the Category model
  BranchModel toBranch() {
    return BranchModel(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      isActive: isActive,
      address: address,
      isOpen: isOpen,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    imageUrl,
    isActive,
    createdAt,
    updatedAt,
    address,
    phone,
    email,
    workingHours,
    location,
    rating,
    discountPercent,
    minOrderAmount,
    isOpen,
    status,
  ];
}
