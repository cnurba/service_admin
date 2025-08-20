import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/categories/application/new_category/new_category_state.dart';
import 'package:service_admin/app/shop/categories/domain/repositories/i_category_repository.dart';
import 'package:service_admin/core/enums/state_type.dart';

class NewCategoryController extends StateNotifier<NewCategoryState> {
  NewCategoryController(this._api) : super((NewCategoryState.initial()));

  final ICategoryRepository _api;

  /// Set image path for the new category.
  void setImagePath(String imagePath) {
    state = state.copyWith(
      category: state.category.copyWith(imageUrl: imagePath,isActive: true),
    );
  }

  /// Set name for the new category.
  void setName(String name) {
    state = state.copyWith(category: state.category.copyWith(name: name));
  }

  /// Set description for the new category.
  void setDescription(String description) {
    state = state.copyWith(
      category: state.category.copyWith(description: description),
    );
  }

  void createCategory() async {
    state = state.copyWith(stateType: StateType.loading);
    try {
      await _api.addCategory(state.category);
      state = state.copyWith(stateType: StateType.success);
    } catch (e) {
      state = state.copyWith(stateType: StateType.error);
    }
  }
}
