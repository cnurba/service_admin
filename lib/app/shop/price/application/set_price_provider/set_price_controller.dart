import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/price/application/price_provider.dart';
import 'package:service_admin/app/shop/price/application/set_price_provider/set_price_state.dart';
import 'package:service_admin/app/shop/price/domain/model/set_price_model.dart';
import 'package:service_admin/app/shop/price/domain/repositories/i_price_repository.dart';
import 'package:service_admin/core/enums/state_type.dart';

final setPriceProvider =
    StateNotifierProvider<SetPriceController, SetPriceState>((ref) {
      return SetPriceController(ref.watch(priceRepositoryProvider));
    });

class SetPriceController extends StateNotifier<SetPriceState> {
  final IPriceRepository _api;

  SetPriceController(this._api) : super(SetPriceState.initial());

  void setPriceTypeUuid(String priceTypeUuid) {
    state = state.copyWith(priceTypeUuid: priceTypeUuid);
  }

  void clear() {
    state = SetPriceState.initial();
  }

  void deletePriceItem(SetPriceModel setPriceModel) {
    final updatedList = state.items
        .where((item) => item != setPriceModel)
        .toList();
    state = state.copyWith(items: updatedList);
  }

  void setPriceItems(SetPriceModel setPriceModel) async {
    /// add item to list
    /// if item already exists, update it
    final index = state.items.indexWhere(
      (item) => item.priceModel == setPriceModel.priceModel,
    );
    if (index == -1) {
      state = state.copyWith(items: [...state.items, setPriceModel]);
    } else {
      final List<SetPriceModel> updatedList = List.from(state.items);
      updatedList[index] = setPriceModel;
      state = state.copyWith(items: updatedList);
    }
  }

  void postPrices() async {
    if (state.items.isEmpty) return;

    state = state.copyWith(stateType: StateType.loading);
    final bool result = await _api.setPrices(state);
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(
      stateType: result ? StateType.success : StateType.error,
    );
    state = state.copyWith(items: []);
  }
}
