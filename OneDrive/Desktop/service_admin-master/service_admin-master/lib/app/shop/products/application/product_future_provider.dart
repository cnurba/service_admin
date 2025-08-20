import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/domain/models/product_model.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_product_repository.dart';
import 'package:service_admin/app/shop/products/infrastructure/repositories/product_repository.dart';
import 'package:service_admin/injection.dart';

final productRepositoryProvider = Provider<IProductRepository>(
  (ref) => ProductRepository(getIt<Dio>()),
);

final productFutureProvider = FutureProvider.autoDispose<List<ProductModel>>((
  ref,
) async {
  final productRepository = ref.watch(productRepositoryProvider);
  final result = await productRepository.getAllProduct();
  return result;
});
