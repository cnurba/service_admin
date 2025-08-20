import 'package:equatable/equatable.dart';

class BranchModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isActive;
  final String address;
  final bool isOpen;

  const BranchModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isActive,
    required this.address,
    required this.isOpen,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    imageUrl,
    isActive,
    address,
    isOpen,
  ];
}
