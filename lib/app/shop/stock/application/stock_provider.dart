import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:service_admin/app/shop/stock/domain/repositories/i_stock_repository.dart';
import 'package:service_admin/app/shop/stock/infrastructure/stock_repository.dart';
import 'package:service_admin/injection.dart';

final stockRepositoryProvider = Provider<IStockRepository>(
  (ref) => StockRepository(getIt<Dio>()),
);

// final priceTypesProvider = FutureProvider<List<PriceTypeModel>>((ref) async {
//   return await ref.read(stockRepositoryProvider).getPriceTypes();
// });
