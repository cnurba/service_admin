import 'dart:io';
import 'package:service_admin/app/shop/products/domain/models/attribute/attribute.dart';
import 'package:service_admin/app/shop/products/domain/models/attribute/product_attribute.dart';
import 'package:service_admin/app/shop/products/domain/models/full_product_model.dart';
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

  Future<List<String>> getProductImagesById(String uuid);

  Future<bool> uploadProductImage(String productId, List<File> files);

  /// Update an existing product.
  Future<void> updateProduct(String id, ProductModel product);

  /// Delete a product by id.
  Future<void> deleteProduct(String id);
  Future<bool> postBranchProducts(List<String> ids);

  Future<List<Attribute>> getAttributes();
  Future<bool> createAttribute(Map<String, dynamic> data);

  Future<List<ProductAttribute>> getProductAttributes(String productId);

  ///Get product attribute
  Future<ProductDetailModel> getProductDetailById(String productId);
}
