import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/stock/domain/models/stock.model.dart';

class SetStockModel extends Equatable {
  final StockModel stockModel;
  final double price;
  final double unit;

  const SetStockModel({
    required this.stockModel,
    required this.price,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'productUuid': stockModel.stock,
      'productPropertyUuid': stockModel.amount,
      'price': price,
    };
  }

  @override
  List<Object?> get props => [stockModel, price];
}
