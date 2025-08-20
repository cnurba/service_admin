import 'package:service_admin/app/shop/products/domain/models/product_model.dart';

abstract class IProductRepository {
  /// Get all products.
  Future<List<ProductModel>> getAllProduct();

  /// Get product by id.
  Future<String> getProductById(String id);

  /// Add a new product.
  Future<void> addProduct(ProductModel product);

  /// Update an existing product.
  Future<void> updateProduct(String id, ProductModel product);

  /// Delete a product by id.
  Future<void> deleteProduct(String id);
}
