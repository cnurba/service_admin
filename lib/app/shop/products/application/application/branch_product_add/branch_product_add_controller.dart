import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/brands/domain/models/brand_model.dart';
import 'package:service_admin/app/shop/categories/domain/models/category_model.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_provider/new_product_state.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_product_repository.dart';

class BranchProductAddController extends StateNotifier<List<String>> {
  BranchProductAddController(this._api) : super(([]));
  final IProductRepository _api;

  void addOrDelete(String productId, bool addMode) {
    if (addMode) {
      if (!state.contains(productId)) {
        state = [...state, productId];
      }
    } else {
      state = state.where((id) => id != productId).toList();
    }
  }

  void clear() {
    state = [];
  }
}
