import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_images/new_poduct_image_state.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_product_repository.dart';

class NewProductImageController extends StateNotifier<NewProductImageState>{
  final IProductRepository _api;
  NewProductImageController(this._api) : super(NewProductImageState.initial());

  void setProductUuid(String uuid) {
    state = state.copyWith(productUuid: uuid);
  }

  void getProductImages() async {
    if(state.productUuid.isEmpty) return;
    final images = await _api.getProductImagesById(state.productUuid);
    state = state.copyWith(images: images);
  }

  // Add your controller logic here
}