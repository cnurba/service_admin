import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/brands/domain/models/brand_model.dart';
import 'package:service_admin/app/shop/categories/domain/models/category_model.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_provider/new_product_state.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_product_repository.dart';
import 'package:service_admin/app/shop/units/domain/unit_model.dart';
import 'package:service_admin/core/enums/state_type.dart';

class NewProductController extends StateNotifier<NewProductState> {
  NewProductController(this._api) : super((NewProductState.initial()));

  final IProductRepository _api;

  void setName(String name) {
    state = state.copyWith(newProduct: state.newProduct.copyWith(name: name));
  }

  void setDescription(String description) {
    state = state.copyWith(
      newProduct: state.newProduct.copyWith(description: description),
    );
  }

  void setCategory(CategoryModel category) {
    state = state.copyWith(
      newProduct: state.newProduct.copyWith(category: category),
    );
  }

  void setBrand(BrandModel brand) {
    state = state.copyWith(newProduct: state.newProduct.copyWith(brand: brand));
  }

  void setSku(String sku) {
    state = state.copyWith(newProduct: state.newProduct.copyWith(sku: sku));
  }

  void setUnit(UnitModel unit) {
    state = state.copyWith(newProduct: state.newProduct.copyWith(unit: unit));
  }

  void setIsActive(bool v) {
    state = state.copyWith(newProduct: state.newProduct.copyWith(isActive: v));
  }

  void setHasAttributes(bool v) {
    state = state.copyWith(
      newProduct: state.newProduct.copyWith(hasAttributes: v),
    );
  }

  void setIsFeatured(bool v) {
    state = state.copyWith(
      newProduct: state.newProduct.copyWith(isFeatured: v),
    );
  }

  void reset() {
    state = NewProductState.initial();
  }

  void post() async {
    state = state.copyWith(stateType: StateType.loading);
    final res = await _api.createProduct(state.newProduct);
    if (res.isNotEmpty) {
      state = state.copyWith(stateType: StateType.success, newProductId: res);
    } else {
      state = state.copyWith(stateType: StateType.error);
    }
  }
}
