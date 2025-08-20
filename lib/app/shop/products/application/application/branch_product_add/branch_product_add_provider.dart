import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/branch_product_add/branch_product_add_controller.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_product_repository.dart';
import 'package:service_admin/injection.dart';

final branchProductAddProvider =
StateNotifierProvider<BranchProductAddController, List<String>>(
      (ref) => BranchProductAddController(getIt<IProductRepository>()),
);
