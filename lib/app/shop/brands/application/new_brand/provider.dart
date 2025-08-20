import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/brands/application/new_brand/new_brand_controller.dart';
import 'package:service_admin/app/shop/brands/application/new_brand/new_brand_state.dart';
import 'package:service_admin/app/shop/brands/domain/repositories/i_brand_repository.dart';
import 'package:service_admin/injection.dart';

final brandProvider = StateNotifierProvider<NewBrandController, NewBrandState>(
  (ref) => NewBrandController(getIt<IBrandRepository>()),
);
