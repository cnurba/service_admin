import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/product_future_provider.dart';

/// Provider to fetch a product by its ID.
/// This provider uses the `FutureProvider` to asynchronously retrieve a product
/// from the repository based on the provided product ID.
final branchProductPostProvider = FutureProvider.autoDispose
    .family<bool, List<String>>((ref, productIds) async {
      final productRepository = ref.watch(productRepositoryProvider);
      return await productRepository.postBranchProducts(productIds);
    });
