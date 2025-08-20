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
  //   Future<ProductModel> getProductById(String id) async {
  //     final response = await _dio.get(
  //       Endpoints.myproducts.productsByProductId(id),
  //     );
  //     final dataList = response.data as List;
  //     if (dataList.isEmpty) throw Exception('No product found with id $id');
  //     return ProductDto.fromJson(dataList.first).toProduct(); // pick first
  //   }
  // }
  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final responseData = await _dio.get(
        Endpoints.myproducts.productsByProductId(id),
      );

      if (responseData.statusCode == 200) {
        final dataList = responseData.data as List; // API returns a list
        if (dataList.isEmpty) throw Exception('No product found with id $id');
        return ProductDto.fromJson(dataList.first).toProduct(); // pick first
      } else {
        throw Exception('Failed to load product with id: $id');
      }
    } catch (e) {
      throw Exception('Error fetching product by id: $e');
    }
  }

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

  // @override
  // Future<List<ProductModel>> getAllProduct() async {
  //   final response = await _dio.get(Endpoints.products.products);
  //   final dataList = response.data as List;
  //   return dataList.map((json) => ProductDto.fromJson(json).toProduct()).toList();
  // }
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

  // @override
  // Future<ProductModel> getProductById(String id) async {
  //   try {
  //     final responseData = await _dio.get(
  //       Endpoints.myproducts.productsByProductId(id),
  //     );
  //     if (responseData.statusCode == 200) {
  //       return ProductDto.fromJson(responseData.data).toProduct();
  //     } else {
  //       throw Exception('Failed to load product with id: $id');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching product by id: $e');
  //   }
  // }

  @override
  Future<void> updateProduct(String id, product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getMyProduct() {
    // TODO: implement getMyProduct
    throw UnimplementedError();
  }
}
