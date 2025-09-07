import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_provider/new_product_controller.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_provider/new_product_state.dart';
import 'package:service_admin/injection.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_product_repository.dart';

final newProductProvider =
    StateNotifierProvider<NewProductController, NewProductState>((ref) {
      return NewProductController(getIt<IProductRepository>());
    });
