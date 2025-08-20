import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/product_future_provider.dart';
import 'package:service_admin/app/shop/products/domain/models/product_model.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_product_repository.dart';
import 'package:service_admin/injection.dart';
/// Provider to fetch a product by its ID.
/// This provider uses the `FutureProvider` to asynchronously retrieve a product
/// from the repository based on the provided product ID.
final branchProductPostProvider = FutureProvider.autoDispose
    .family<bool, List<String>>((ref, productIds) async {
      final productRepository = ref.watch(productRepositoryProvider);
      return await productRepository.postBranchProducts(productIds);

    });
