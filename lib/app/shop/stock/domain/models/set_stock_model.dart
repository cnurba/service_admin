import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/stock/domain/models/stock.model.dart';

class SetStockModel extends Equatable {
  final String type;
  final StockModel stockModel;
  final double price;
  final double stock;
   final double amount;

  const SetStockModel({
    required this.stockModel,
    required this.price,
    required this.stock,
    required this.amount,
    this.type = 'set',
  });

  Map<String, dynamic> toJson() {
    return {
      'productUuid': stockModel.productUuid,
      'productPropertyUuid': stockModel.productPropertyUuid,
      'stock': stock,
      'price': price,
      'amount': amount,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [stockModel, price, stock, amount];
}
