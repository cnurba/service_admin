import 'package:service_admin/app/shop/brands/domain/models/brand_model.dart';

abstract class IBrandRepository {
  /// Get all categories.
  Future<List<BrandModel>> getAllBrands();

  /// Get category by id.
  Future<String> getBrandById(String id);

  /// Add a new category.
  Future<bool> addBrand(BrandModel brand);

  /// Update an existing category.
  Future<void> updateBrand(String id, BrandModel brand);

  /// Delete a category by id.
  Future<void> deleteBrand(String id);
}
