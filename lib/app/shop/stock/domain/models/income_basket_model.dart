import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/stock/domain/models/income_model.dart';

class IncomeBasketModel extends Equatable {
  final IncomeModel incomeModel;
  final double price;
  final double stock;
  final double amount;

  const IncomeBasketModel({
    required this.incomeModel,
    required this.price,
    required this.stock,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'productUuid': incomeModel.productUuid,
      'productPropertyUuid': incomeModel.productPropertyUuid,
      'stock': stock,
      'price': price,
      'amount': amount,
    };
  }

  copyWith({
    IncomeModel? incomeModel,
    double? price,
    double? stock,
    double? amount,
  }) {
    return IncomeBasketModel(
      incomeModel: incomeModel ?? this.incomeModel,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props => [incomeModel, price, stock, amount];
}
