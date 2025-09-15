import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/stock/domain/repositories/i_income_repository.dart';
import 'package:service_admin/app/shop/stock/infrastructure/income_repository.dart';
import 'package:service_admin/injection.dart';

final incomeRepositoryProvider = Provider<IIncomeRepository>(
  (ref) => IncomeRepository(getIt<Dio>()),
);
