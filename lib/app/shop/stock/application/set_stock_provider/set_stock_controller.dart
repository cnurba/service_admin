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
}