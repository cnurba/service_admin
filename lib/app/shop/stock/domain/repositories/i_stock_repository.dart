import 'package:service_admin/app/shop/stock/application/set_stock_provider/set_stock_state.dart';

abstract class IStockRepository {
  Future<bool> setStocks(SetStockState state);
}
