import 'package:service_admin/app/shop/categories/domain/models/category_model.dart';

abstract class ICategoryRepository {
  /// Get all categories.
  Future<List<CategoryModel>> getAllCategories();

  /// Get category by id.
  Future<String> getCategoryById(String id);

  /// Add a new category.
  Future<bool> addCategory(CategoryModel category);

  /// Update an existing category.
  Future<void> updateCategory(String id, CategoryModel category);

  /// Delete a category by id.
  Future<void> deleteCategory(String id);
}
