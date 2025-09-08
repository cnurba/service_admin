import 'package:service_admin/app/shop/stock/application/set_stock_provider/set_stock_state.dart';
import 'package:service_admin/app/shop/stock/domain/models/stock.model.dart';

abstract class IStockRepository {
  Future<bool> setStocks(SetStockState state, String type);
  Future<List<StockModel>> getStocks(String type);
}
