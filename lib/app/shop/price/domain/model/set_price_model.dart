import 'package:equatable/equatable.dart';

class SetPriceModel extends Equatable{
  final String productUuid;
  final String productPropertyUuid;
  final double price;

  const SetPriceModel({
    required this.productUuid,
    required this.productPropertyUuid,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_uuid': productUuid,
      'product_property_uuid': productPropertyUuid,
      'price': price,
    };
  }

  @override
  List<Object?> get props => [productUuid, productPropertyUuid, price];

}