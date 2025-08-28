import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:service_admin/app/shop/price/domain/model/price_model.dart';
import 'package:service_admin/app/shop/price/domain/model/price_type_model.dart';
import 'package:service_admin/app/shop/price/domain/repositories/i_price_repository.dart';
import 'package:service_admin/app/shop/price/infrastructure/price_repository.dart';
import 'package:service_admin/injection.dart';

final priceRepositoryProvider = Provider<IPriceRepository>(
  (ref) => PriceRepository(getIt<Dio>()),
);

final priceTypesProvider = FutureProvider<List<PriceTypeModel>>((ref) async {
  return await ref.read(priceRepositoryProvider).getPriceTypes();
});

