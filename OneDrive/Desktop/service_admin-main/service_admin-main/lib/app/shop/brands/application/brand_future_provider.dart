import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/brands/domain/models/brand_model.dart';
import 'package:service_admin/app/shop/brands/domain/repositories/i_brand_repository.dart';
import 'package:service_admin/app/shop/brands/infrastructure/repositories/brand_repository.dart';
import 'package:service_admin/injection.dart';

final brandRepositoryProvider = Provider<IBrandRepository>(
  (ref) => BrandRepository(getIt<Dio>()),
);

final brandFutureProvider = FutureProvider.autoDispose<List<BrandModel>>((
  ref,
) async {
  final brandRepository = ref.watch(brandRepositoryProvider);
  final result = await brandRepository.getAllBrands();
  return result;
});
