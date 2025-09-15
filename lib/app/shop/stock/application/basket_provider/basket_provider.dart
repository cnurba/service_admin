import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/stock/application/basket_provider/basket_state.dart';
import 'package:service_admin/app/shop/stock/application/income_repository_provider.dart';
import 'package:service_admin/app/shop/stock/domain/models/income_basket_model.dart';
import 'package:service_admin/app/shop/stock/domain/models/income_model.dart';
import 'package:service_admin/app/shop/stock/domain/repositories/i_income_repository.dart';

import 'package:service_admin/core/enums/state_type.dart';
import 'package:service_admin/core/presentation/errors/failure.dart';

final basketProvider = StateNotifierProvider<BasketController, BasketState>((
  ref,
) {
  return BasketController(ref.watch(incomeRepositoryProvider));
});

class BasketController extends StateNotifier<BasketState> {
  final IIncomeRepository _api;

  BasketController(this._api) : super(BasketState.initial());

  void clear() {
    state = BasketState.initial();
  }

  void setType(String type) {
    state = state.copyWith(type: type);
  }

  void deleteItem(IncomeBasketModel setStockModel) {
    final updatedList = state.items
        .where((item) => item != setStockModel)
        .toList();
    state = state.copyWith(items: updatedList);
  }

  void setItem(IncomeModel incomeModel) async {
    /// add item to list
    /// if item already exists, update it
    final index = state.items.indexWhere(
      (item) => item.incomeModel == incomeModel,
    );
    if (index == -1) {
      state = state.copyWith(
        items: [...state.items, incomeModel.toIncomeBasketModel()],
      );
    } else {
      final List<IncomeBasketModel> updatedList = List.from(state.items);
      updatedList[index] = incomeModel.toIncomeBasketModel();
      state = state.copyWith(items: updatedList);
    }
  }

  void setPrice(double price, IncomeModel incomeModel) {
    if (state.items.isEmpty) return;

    /// Check if the incomeModel exists in the list
    /// if it does, update its price
    final index = state.items.indexWhere(
      (item) => item.incomeModel == incomeModel,
    );
    if (index == -1) return;
    final List<IncomeBasketModel> updatedList = List.from(state.items);
    updatedList[index] = updatedList[index].copyWith(price: price);
    updatedList[index] = updatedList[index].copyWith(
      amount: price * updatedList[index].stock,
    );
    state = state.copyWith(items: updatedList);
  }

  void setStock(double stock, IncomeModel incomeModel) {
    if (state.items.isEmpty) return;

    /// Check if the incomeModel exists in the list
    /// if it does, update its count
    final index = state.items.indexWhere(
      (item) => item.incomeModel == incomeModel,
    );
    if (index == -1) return;
    final List<IncomeBasketModel> updatedList = List.from(state.items);
    updatedList[index] = updatedList[index].copyWith(stock: stock);
    updatedList[index] = updatedList[index].copyWith(
      amount: stock * updatedList[index].price,
    );
    state = state.copyWith(items: updatedList);
  }
  //
  // void postStocks() async {
  //   if (state.items.isEmpty) return;
  //   state = state.copyWith(stateType: StateType.loading);
  //   final FailureModel result = await _api.post(state, state.type);
  //   await Future.delayed(const Duration(seconds: 2));
  //   state = state.copyWith(
  //     stateType: result.hasError ? StateType.error : StateType.success,
  //   );
  //   Future.delayed(const Duration(seconds: 2));
  //   // if (!result.hasError) {
  //   //   state = BasketState.initial();
  //   // }
  // }
}
