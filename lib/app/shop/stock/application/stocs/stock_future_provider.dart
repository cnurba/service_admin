import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/stock/domain/models/stock.model.dart';
import 'package:service_admin/app/shop/stock/domain/repositories/i_stock_repository.dart';
import 'package:service_admin/app/shop/stock/infrastructure/stock_repository.dart';
import 'package:service_admin/injection.dart';

final stockRepositoryProvider = Provider<IStockRepository>(
  (ref) => StockRepository(getIt<Dio>()),
);

final stockFutureProvider = FutureProvider.autoDispose<List<IncomeModel>>((
  ref,
) async {
  final stockRepository = ref.watch(stockRepositoryProvider);
  final result = await stockRepository.getStocks('income');
  return result;
});
