import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/stock/domain/models/stock.model.dart';

class SetStockModel extends Equatable {
  final String type;
  final IncomeModel incomeModel;
  final double price;
  final double stock;
  final double amount;

  const SetStockModel({
    required this.incomeModel,
    required this.price,
    required this.stock,
    required this.amount,
    this.type = 'set',
  });

  Map<String, dynamic> toJson() {
    return {
      'productUuid': incomeModel.productUuid,
      'productPropertyUuid': incomeModel.productPropertyUuid,
      'stock': stock,
      'price': price,
      'amount': amount,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [incomeModel, price, stock, amount, type];
}
