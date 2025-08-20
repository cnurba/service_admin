import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/product_future_provider.dart';
import 'package:service_admin/app/shop/products/domain/models/product_model.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_product_repository.dart';
import 'package:service_admin/injection.dart';

// Repository provider using GetIt
// final productRepositoryProvider = Provider<IProductRepository>(
//   (ref) => getIt<IProductRepository>(),
// );
// final productByProductIdFutureProvider = FutureProvider.autoDispose
//     .family<ProductModel, String>((ref, productId) async {
//       final repo = ref.watch(productRepositoryProvider);
//       return repo.getProductById(productId);
//     });

final productByProductIdFutureProvider = FutureProvider.autoDispose
    .family<ProductModel, String>((ref, productId) async {
      final productRepository = ref.watch(productRepositoryProvider);
      final product = await productRepository.getProductById(productId);
      return product;
    });
