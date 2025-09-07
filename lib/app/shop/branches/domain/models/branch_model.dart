import 'package:equatable/equatable.dart';
import 'package:service_admin/core/http/server_address.dart';

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
  String get imagePath {
    return imageUrl.isNotEmpty
        ? "${ServerAddress().imageUrl}$imageUrl"
        : 'https://via.placeholder.com/150';
  }

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
