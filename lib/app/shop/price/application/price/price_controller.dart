import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/price/application/price_provider.dart';
import 'package:service_admin/app/shop/price/domain/model/price_model.dart';
import 'package:service_admin/app/shop/price/domain/repositories/i_price_repository.dart';

final priceProvider = StateNotifierProvider<PriceController, List<PriceModel>>((
  ref,
) {
  return PriceController(ref.watch(priceRepositoryProvider));
});

class PriceController extends StateNotifier<List<PriceModel>> {
  final IPriceRepository _api;
  PriceController(this._api) : super([]);

  Future<void> loadPrices(String priceTypeUuid) async {
    final prices = await _api.getPricesByType(priceTypeUuid);
    state = prices;
  }

  // Add your controller logic here
}
