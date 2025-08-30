import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:service_admin/app/shop/products/domain/models/attribute/attribute.dart';
import 'package:service_admin/app/shop/products/domain/models/attribute/product_attribute.dart';
import 'package:service_admin/app/shop/products/domain/models/new/new_product_model.dart';
import 'package:service_admin/app/shop/products/domain/models/product_model.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_product_repository.dart';
import 'package:service_admin/app/shop/products/infrastructure/dtos/product_dto.dart';
import 'package:service_admin/core/http/endpoints.dart';

class ProductRepository implements IProductRepository {
  final Dio _dio;

  ProductRepository(this._dio);

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
  Future<void> updateProduct(String id, product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getMyProducts() async {
    try {
      final responseData = await _dio.get(Endpoints.myproducts.myproducts);
      if (responseData.statusCode == 200) {
        final myProductsList = (responseData.data as List)
            .map((myProducts) => ProductDto.fromJson(myProducts).toProduct())
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
  Future<bool> postBranchProducts(List<String> ids) async {
    try {
      log("START BRANCH PRODUCT POST REQUEST");
      await _dio.post(Endpoints.products.branchProducts, data: ids);
      log("FINISH BRANCH PRODUCT POST ");
      return true;
    } catch (e) {
      log("Error fetching objects: $e");
      return false;
    }
  }

  @override
  Future<String> createProduct(NewProductModel product) async {
    try {
      log("START PRODUCT POST REQUEST");
      final result = await _dio.post(
        Endpoints.products.products,
        data: product.toJson(),
      );
      log("FINISH PRODUCT POST ");
      return result.data['id'];
    } catch (e) {
      log("Error fetching objects: $e");
      return "";
    }
  }

  @override
  Future<List<String>> getProductImagesById(String uuid) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> uploadProductImage(String productId, List<File> files) async {
    try {
      log("START UPLOAD PRODUCT IMAGES REQUEST");
      final formData = FormData.fromMap({
        'images': files
            .map(
              (file) => MultipartFile.fromFileSync(
                file.path,
                filename: file.path.split(Platform.pathSeparator).last,
              ),
            )
            .toList(),
      });
      final responseData = await _dio.post(
        Endpoints.files.fileProduct,
        data: formData,
        queryParameters: {'id': productId},
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'catalog': "Product",
          },
        ),
      );
      log("FINISH UPLOAD PRODUCT IMAGES ");
      return !responseData.data['error'];
    } catch (e) {
      log("Error uploading images: $e");
      return false;
    }
  }

  @override
  Future<List<Attribute>> getAttributes() async {
    try {
      final responseData = await _dio.get(Endpoints.products.attributes);
      if (responseData.statusCode == 200) {
        final attributes = (responseData.data as List)
            .map((items) => Attribute.fromJson(items))
            .toList();
        log("FINISH Products length  ${attributes.length}");
        return attributes;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  @override
  Future<bool> createAttribute(Map<String, dynamic> data) async {
    try {
      final responseData = await _dio.post(
        Endpoints.products.attributes,
        data: data,
      );
      if (responseData.statusCode == 200) {
        return !responseData.data['error'];
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  @override
  Future<List<ProductAttribute>> getProductAttributes(String productId) async {
    try {
      final responseData = await _dio.get(
        Endpoints.products.productAttributes,
        queryParameters: {'id': productId},
      );
      if (responseData.statusCode == 200) {
        final attributes = (responseData.data as List)
            .map((items) => ProductAttribute.fromJson(items))
            .toList();
        log("FINISH Products length  ${attributes.length}");
        return attributes;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
