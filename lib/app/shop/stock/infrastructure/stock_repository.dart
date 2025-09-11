import 'package:dio/dio.dart';
import 'package:service_admin/app/shop/stock/application/set_stock_provider/set_stock_state.dart';
import 'package:service_admin/app/shop/stock/domain/models/stock.model.dart';
import 'package:service_admin/app/shop/stock/domain/repositories/i_stock_repository.dart';

class StockRepository implements IStockRepository {
  final Dio _dio;
  StockRepository(this._dio);

  @override
  Future<bool> setStocks(SetStockState state, String type) async {
    try {
      final data = state.items.map((e) => e.toJson()).toList();
      await _dio.post('/stock/set', data: data);
      return true;
    } catch (e) {
      print("Error sending stocks: $e");
      return false;
    }
  }

  @override
  Future<List<IncomeModel>> getStocks(String type) async {
    throw UnimplementedError();
  }
}
