import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/stock/application/set_stock_provider/set_stock_state.dart';
import 'package:service_admin/app/shop/stock/application/stock_provider.dart';
import 'package:service_admin/app/shop/stock/domain/models/set_stock_model.dart';
import 'package:service_admin/app/shop/stock/domain/repositories/i_stock_repository.dart';
import 'package:service_admin/core/enums/state_type.dart';

final setStockProvider =
    StateNotifierProvider<SetStockController, SetStockState>((ref) {
      return SetStockController(ref.watch(stockRepositoryProvider));
    });

class SetStockController extends StateNotifier<SetStockState> {
  final IStockRepository _api;

  SetStockController(this._api) : super(SetStockState.initial());

  // void setPriceTypeUuid(String priceTypeUuid) {
  //   state = state.copyWith(priceTypeUuid: priceTypeUuid);
  // }

  void clear() {
    state = SetStockState.initial();
  }

  void deleteStockItem(SetStockModel setStockModel) {
    final updatedList = state.items
        .where((item) => item != setStockModel)
        .toList();
    state = state.copyWith(items: updatedList);
  }

  void setStockItems(SetStockModel setStockModel) async {
    /// add item to list
    /// if item already exists, update it
    final index = state.items.indexWhere(
      (item) => item.incomeModel == setStockModel.incomeModel,
    );
    if (index == -1) {
      state = state.copyWith(items: [...state.items, setStockModel]);
    } else {
      final List<SetStockModel> updatedList = List.from(state.items);
      updatedList[index] = setStockModel;
      state = state.copyWith(items: updatedList);
    }
  }

  void postStocks() async {
    if (state.items.isEmpty) return;

    state = state.copyWith(stateType: StateType.loading);
    final bool result = await _api.setStocks(state, 'income');
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(
      stateType: result ? StateType.success : StateType.error,
    );
    state = state.copyWith(items: []);
  }
}
