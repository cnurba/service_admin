import 'package:service_admin/app/shop/products/domain/models/my_product_model.dart';
import 'package:service_admin/app/shop/products/domain/models/product_model.dart';

abstract class IMyProductRepository {
  /// Get all products.
  Future<List<ProductModel>> getAllProduct();

  Future<List<MyProductModel>> getMyProduct();

  /// Get product by id.
  Future<String> getMyProductById(String id);

  /// Add a new product.
  Future<void> addMyProduct(MyProductModel myproduct);

  /// Update an existing product.
  Future<void> updateMyProduct(String id, MyProductModel myproduct);

  /// Delete a product by id.
  Future<void> deleteMyProduct(String id);
}
