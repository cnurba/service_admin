import 'package:equatable/equatable.dart';

/// Model class for Product Attribute [Свойство номенклатуры в 1С]
/// with fields:
/// - [name] - Name of the attribute.
/// - [productName] - productName.
/// - [uuid] - Unique identifier of the attribute.
class ProductAttribute extends Equatable {
  final String name;
  final String productName;
  final String uuid;

  const ProductAttribute({
    required this.name,
    required this.productName,
    required this.uuid,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      name: json['name'] ?? '',
      productName: json['productName'] ?? '',
      uuid: json['uuid'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'productName': productName,
      'uuid': uuid,
    };
  }

  factory ProductAttribute.empty() {
    return const ProductAttribute(
      name: '',
      productName: '',
      uuid: '',
    );
  }
  copyWith({
    String? name,
    String? productName,
    String? uuid,
  }) {
    return ProductAttribute(
      name: name ?? this.name,
      productName: productName ?? this.productName,
      uuid: uuid ?? this.uuid,
    );
  }
  @override
  List<Object?> get props => [name, productName, uuid];

  @override
  String toString() {
    return 'Attribute{name: $name, type: $productName, uuid: $uuid}';
  }
}