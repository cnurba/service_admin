import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/brands/application/new_brand/new_brand_state.dart';
import 'package:service_admin/app/shop/brands/domain/repositories/i_brand_repository.dart';
import 'package:service_admin/core/enums/state_type.dart';

class NewBrandController extends StateNotifier<NewBrandState> {
  NewBrandController(this._api) : super((NewBrandState.initial()));

  final IBrandRepository _api;

  /// Set image path for the new category.
  void setImagePath(String imagePath) {
    state = state.copyWith(
      brand: state.brand.copyWith(logoUrl: imagePath, isActive: true),
    );
  }

  /// Set name for the new category.
  void setName(String name) {
    state = state.copyWith(brand: state.brand.copyWith(name: name));
  }

  /// Set description for the new category.
  void setDescription(String description) {
    state = state.copyWith(
      brand: state.brand.copyWith(description: description),
    );
  }

  void createBrand() async {
    state = state.copyWith(stateType: StateType.loading);
    try {
      await _api.addBrand(state.brand);
      state = state.copyWith(stateType: StateType.success);
    } catch (e) {
      state = state.copyWith(stateType: StateType.error);
    }
  }
}
