import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/stock/application/stock_provider.dart';
import 'package:service_admin/app/shop/stock/domain/models/set_stock_model.dart';
import 'package:service_admin/app/shop/stock/domain/repositories/i_stock_repository.dart';
import 'package:service_admin/app/shop/stock/application/set_stock_provider/set_stock_state.dart';
import 'package:service_admin/core/enums/state_type.dart';

final setStockProvider =
    StateNotifierProvider<SetStockController, SetStockState>((ref) {
      return SetStockController(ref.watch(stockRepositoryProvider));
    });

class SetStockController extends StateNotifier<SetStockState> {
  final IStockRepository _api;

  SetStockController(this._api) : super(SetStockState.initial());

  void clear() {
    state = SetStockState.initial();
  }

  void setStockItems(SetStockModel model) {
    final index = state.items.indexWhere(
      (e) => e.stockModel == model.stockModel,
    );
    final updated = List<SetStockModel>.from(state.items);

    if (index == -1) {
      updated.add(model);
    } else {
      updated[index] = model;
    }
    state = state.copyWith(items: updated);
  }

  void deleteStockItem(SetStockModel model) {
    final updated = state.items.where((e) => e != model).toList();
    state = state.copyWith(items: updated);
  }

  Future<void> postStocks() async {
    if (state.items.isEmpty) return;
    state = state.copyWith(stateType: StateType.loading);
    final success = await _api.setStocks(state);
    state = state.copyWith(
      stateType: success ? StateType.success : StateType.error,
      items: [],
    );
  }
}
