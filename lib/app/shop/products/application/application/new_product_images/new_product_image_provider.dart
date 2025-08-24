import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_images/new_poduct_image_state.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_images/new_product_image_controller.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_product_repository.dart';
import 'package:service_admin/injection.dart';

final newProductImageProvider =
    StateNotifierProvider<NewProductImageController, NewProductImageState>((
      ref,
    ) {
      return NewProductImageController(getIt<IProductRepository>());
    });
