import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/product_future_provider.dart';
import 'package:service_admin/app/shop/products/domain/models/attribute/product_attribute.dart';

final productAttributeFutureProvider = FutureProvider.autoDispose.family<
    List<ProductAttribute>, String>((ref, productId) async {
  final repo = ref.watch(productRepositoryProvider);
  final success = await repo.getProductAttributes(productId);
  return success;
});
