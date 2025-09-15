import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/stock/domain/models/income_model.dart';
import 'package:service_admin/app/shop/stock/domain/repositories/i_income_repository.dart';
import 'package:service_admin/app/shop/stock/infrastructure/income_repository.dart';
import 'package:service_admin/injection.dart';

final stockRepositoryProvider = Provider<IIncomeRepository>(
  (ref) => IncomeRepository(getIt<Dio>()),
);

final incomeFutureProvider = FutureProvider.autoDispose<List<IncomeModel>>((
  ref,
) async {
  final incomeRepository = ref.watch(stockRepositoryProvider);
  final result = await incomeRepository.getProductsWithAttributes();
  return result;
});
