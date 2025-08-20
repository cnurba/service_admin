import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/categories/domain/models/category_model.dart';
import 'package:service_admin/app/shop/categories/domain/repositories/i_category_repository.dart';
import 'package:service_admin/app/shop/categories/infrastructure/repositories/category_repository.dart';
import 'package:service_admin/injection.dart';

final categoryRepositoryProvider = Provider<ICategoryRepository>(
  (ref) => CategoryRepository(getIt<Dio>()),
);

final categoryFutureProvider = FutureProvider.autoDispose<List<CategoryModel>>((
  ref,
) async {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  final result = await categoryRepository.getAllCategories();
  return result;
});
