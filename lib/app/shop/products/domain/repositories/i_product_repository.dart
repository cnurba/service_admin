import 'package:service_admin/app/shop/products/domain/models/new/new_product_model.dart';
import 'package:service_admin/app/shop/products/domain/models/product_model.dart';

abstract class IProductRepository {
  /// Get all products.
  Future<List<ProductModel>> getAllProduct();

  Future<List<ProductModel>> getMyProducts();

  /// Get product by id.
  Future<ProductModel> getProductById(String productId);

  /// Add a new product.
  Future<void> addProduct(ProductModel product);


  Future<String> createProduct(NewProductModel product);

  /// Update an existing product.
  Future<void> updateProduct(String id, ProductModel product);

  /// Delete a product by id.
  Future<void> deleteProduct(String id);
  Future<bool> postBranchProducts(List<String> ids);
}
