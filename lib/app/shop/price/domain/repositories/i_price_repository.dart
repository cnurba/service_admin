import 'package:service_admin/app/shop/price/application/set_price_provider/set_price_state.dart';
import 'package:service_admin/app/shop/price/domain/model/price_model.dart';
import 'package:service_admin/app/shop/price/domain/model/price_type_model.dart';

abstract class IPriceRepository {
  Future<List<PriceTypeModel>> getPriceTypes();
  Future<List<PriceModel>> getPricesByType(String priceTypeUuid);
  Future<bool> setPrices(SetPriceState state);
}
