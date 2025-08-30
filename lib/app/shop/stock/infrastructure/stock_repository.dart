import 'package:dio/dio.dart';
import 'package:service_admin/app/shop/price/application/set_price_provider/set_price_state.dart';
import 'package:service_admin/app/shop/stock/domain/repositories/i_stock_repository.dart';

class StockRepository implements IStockRepository {
  final Dio _dio;

  StockRepository(this._dio);

  @override
  Future<bool> setPrices(SetPriceState state) {
    // TODO: implement setPrices
    throw UnimplementedError();
  }
}
