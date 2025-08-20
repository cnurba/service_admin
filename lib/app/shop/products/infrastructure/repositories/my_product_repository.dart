import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:service_admin/app/shop/products/domain/models/my_product_model.dart';
import 'package:service_admin/app/shop/products/domain/models/product_model.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_my_product_repository.dart';
import 'package:service_admin/app/shop/products/infrastructure/dtos/my_product_dto.dart';
import 'package:service_admin/core/http/endpoints.dart';

class MyProductRepository implements IMyProductRepository {
  final Dio _dio;

  MyProductRepository(this._dio);

  @override
  Future<void> addMyProduct(MyProductModel myproduct) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMyProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<List<MyProductModel>> getMyProduct() async {
    try {
      final responseData = await _dio.get(Endpoints.myproducts.myproducts);
      if (responseData.statusCode == 200) {
        final myProductsList = (responseData.data as List)
            .map(
              (myproducts) => MyProductDto.fromJson(myproducts).toMyProduct(),
            )
            .toList();
        log("FINISH Products length  ${myProductsList.length}");
        return myProductsList;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  @override
  Future<String> getMyProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<void> updateMyProduct(String id, myproduct) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getAllProduct() {
    // TODO: implement getAllProduct
    throw UnimplementedError();
  }
}
