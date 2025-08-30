// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:service_admin/app/shop/stock/application/stock_provider.dart';
// import 'package:service_admin/app/shop/stock/domain/repositories/i_stock_repository.dart';
//
// final setStockProvider =
//     StateNotifierProvider<SetStockController, SetStockState>((ref) {
//       return SetStockController(ref.watch(stockRepositoryProvider));
//     });

class SetStockController extends StateNotifier<SetStockState> {
  final IStockRepository _api;
}

SetStockController(this._api) : super(SetStockState.initial());
