import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/price/domain/model/price_model.dart';

class SetPriceModel extends Equatable{
  final PriceModel priceModel;
  final double price;

  const SetPriceModel({
    required this.priceModel,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'productUuid': priceModel.productUuid,
      'productPropertyUuid': priceModel.productPropertyUuid,
      'price': price,
    };
  }

  @override
  List<Object?> get props => [priceModel, price];

}