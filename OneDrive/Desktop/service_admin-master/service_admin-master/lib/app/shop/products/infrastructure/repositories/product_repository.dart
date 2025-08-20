import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:service_admin/app/shop/products/domain/models/product_model.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_product_repository.dart';
import 'package:service_admin/app/shop/products/infrastructure/dtos/product_dto.dart';
import 'package:service_admin/core/http/endpoints.dart';

class ProductRepository implements IProductRepository {
  final Dio _dio;

  ProductRepository(this._dio);

  @override
  Future<void> addProduct(ProductModel product) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getAllProduct() async {
    try {
      final responseData = await _dio.get(Endpoints.products.products);
      if (responseData.statusCode == 200) {
        final productsList = (responseData.data as List)
            .map((products) => ProductDto.fromJson(products).toProduct())
            .toList();
        log("FINISH Products length  ${productsList.length}");
        return productsList;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  @override
  Future<String> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(String id, product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
