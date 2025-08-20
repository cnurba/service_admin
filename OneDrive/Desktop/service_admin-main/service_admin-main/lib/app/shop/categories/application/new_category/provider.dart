import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/categories/domain/repositories/i_category_repository.dart';
import 'package:service_admin/injection.dart';
import 'new_category_controller.dart';
import 'new_category_state.dart';

final categoryProvider =
    StateNotifierProvider<NewCategoryController, NewCategoryState>(
      (ref) => NewCategoryController(getIt<ICategoryRepository>()),
    );
