import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/products/domain/models/attribute/attribute.dart';

class AttributeAdditionalValue extends Equatable {
  final Attribute attribute;
  final String name;

  const AttributeAdditionalValue({
    required this.name,
    required this.attribute,
  });

  /// factory constructor from json
  factory AttributeAdditionalValue.fromJson(Map<String, dynamic> json) {
    return AttributeAdditionalValue(
      name: json['name'] ?? '',
      attribute: Attribute.fromJson(json['attribute'] ?? {}),
    );
  }

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'attribute': attribute.toJson(),
    };
  }

  factory AttributeAdditionalValue.empty() {
    return AttributeAdditionalValue(
      name: '',
      attribute: Attribute.empty(),
    );
  }

  copyWith({
    String? name,
    Attribute? attribute,
  }) {
    return AttributeAdditionalValue(
      name: name ?? this.name,
      attribute: attribute ?? this.attribute,
    );
  }

  @override
  List<Object?> get props => [name, attribute];

}