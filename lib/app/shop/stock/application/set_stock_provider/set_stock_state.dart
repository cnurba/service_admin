// import 'package:equatable/equatable.dart';
// import 'package:service_admin/app/shop/stock/domain/models/set_stock_model.dart';

import 'package:service_admin/app/shop/stock/domain/models/stock.model.dart';

class SetStockState extends Equatable {
  final String type;
  final List<StockModel> items;
  final StateType stateType;

  @override
  List<Object?> get props => throw UnimplementedError();
}
