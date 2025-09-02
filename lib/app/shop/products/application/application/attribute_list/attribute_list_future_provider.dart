import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/product_future_provider.dart';
import 'package:service_admin/app/shop/products/domain/models/attribute/attribute.dart';

/// A FutureProvider that fetches a list of attributes from the product repository.
/// This provider is auto-disposed when no longer needed.
/// It watches the [productRepositoryProvider] to get the repository instance
/// and calls the [getAttributes] method to retrieve the data.
final attributeFutureProvider = FutureProvider.autoDispose<List<Attribute>>((
  ref,
) async {
  final repo = ref.watch(productRepositoryProvider);

  final attributes = await repo.getAttributes();

  return attributes;
});

final attributeCreateProvider = FutureProvider.autoDispose.family<
    bool, Map<String, dynamic>>((ref, data) async {
  final repo = ref.watch(productRepositoryProvider);
  final success = await repo.createAttribute(data);
  return success;
});
