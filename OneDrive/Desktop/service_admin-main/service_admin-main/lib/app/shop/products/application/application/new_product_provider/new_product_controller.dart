import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/brands/domain/models/brand_model.dart';
import 'package:service_admin/app/shop/categories/domain/models/category_model.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_provider/new_product_state.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_product_repository.dart';

class NewProductController extends StateNotifier<NewProductState> {
  NewProductController(this._api) : super((NewProductState.initial()));

  final IProductRepository _api;

  void setName(String name) {
    state = state.copyWith(newProduct: state.newProduct.copyWith(name: name));
  }

  void setDescription(String description) {
    state = state.copyWith(newProduct: state.newProduct.copyWith(description: description));
  }

  void setCategory(CategoryModel category) {
    state = state.copyWith(newProduct: state.newProduct.copyWith(category: category));
  }

  void setBrand(BrandModel brand) {
    state = state.copyWith(newProduct: state.newProduct.copyWith(brand: brand));
  }

}