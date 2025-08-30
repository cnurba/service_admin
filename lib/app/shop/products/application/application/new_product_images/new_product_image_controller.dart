import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_images/new_poduct_image_state.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_product_repository.dart';
import 'package:service_admin/core/enums/state_type.dart';

class NewProductImageController extends StateNotifier<NewProductImageState> {
  final IProductRepository _api;

  NewProductImageController(this._api) : super(NewProductImageState.initial());

  void reset() {
    state = NewProductImageState.initial();
  }

  void setProductUuid(String uuid) {
    state = state.copyWith(productUuid: uuid);
  }

  void getProductImages() async {
    if (state.productUuid.isEmpty) return;
    final images = await _api.getProductImagesById(state.productUuid);
    state = state.copyWith(images: images);
  }

  void postImages() async {
    if (state.productUuid.isEmpty) return;
    state = state.copyWith(stateType: StateType.loading);
    final result = await _api.uploadProductImage(
      state.productUuid,
      state.selectedImages,
    );
    Future.delayed(const Duration(seconds: 1));
    if (result) {
      state = state.copyWith(stateType: StateType.success);
      Future.delayed(const Duration(seconds: 3), () {
        state = state.copyWith(stateType: StateType.initial);
      });
    } else {
      state = state.copyWith(stateType: StateType.error);
    }
  }

  void addImage(File image) {
    final selectedImages = List<File>.from(state.selectedImages);
    selectedImages.add(image);
    state = state.copyWith(selectedImages: selectedImages);
  }

  void removeImageAt(int index) {
    final selectedImages = List<File>.from(state.selectedImages);
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
      state = state.copyWith(selectedImages: selectedImages);
    }
  }

  // Add your controller logic here
}
