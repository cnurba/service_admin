import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/domain/models/my_product_model.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_my_product_repository.dart';
import 'package:service_admin/app/shop/products/infrastructure/repositories/my_product_repository.dart';
import 'package:service_admin/injection.dart';

final myProductRepositoryProvider = Provider<IMyProductRepository>(
  (ref) => MyProductRepository(getIt<Dio>()),
);

final myProductFutureProvider =
    FutureProvider.autoDispose<List<MyProductModel>>((ref) async {
      final myProductRepository = ref.watch(myProductRepositoryProvider);
      final result = await myProductRepository.getMyProduct();
      return result;
    });
