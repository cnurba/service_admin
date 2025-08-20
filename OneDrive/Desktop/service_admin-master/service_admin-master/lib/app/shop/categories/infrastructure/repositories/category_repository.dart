import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:service_admin/app/shop/categories/domain/models/category_model.dart';
import 'package:service_admin/app/shop/categories/domain/repositories/i_category_repository.dart';
import 'package:service_admin/app/shop/categories/infrastructure/dtos/category_dto.dart';
import 'package:service_admin/core/http/endpoints.dart';

class CategoryRepository implements ICategoryRepository {
  final Dio _dio;

  CategoryRepository(this._dio);

  @override
  Future<bool> addCategory(CategoryModel category) async {
    try {
      log("START NEW CATEGORY MODEL REQUEST");
      final categoryData = CategoryDto.fromCategory(category).toJson();
      final responseData = await _dio.post(
        Endpoints.categories.categories,
        data: categoryData,
      );
      log("FINISH CATEGORY MODEL ${responseData.data}");
      return true;
    } catch (e) {
      log("Error fetching objects: $e");
      return false;
    }
  }

  @override
  Future<void> deleteCategory(String id) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final responseData = await _dio.get(Endpoints.categories.categories);
      if (responseData.statusCode == 200) {
        final categoriesList = (responseData.data as List)
            .map((categories) => CategoryDto.fromJson(categories).toCategory())
            .toList();
        log("FINISH Categories length  ${categoriesList.length}");
        return categoriesList;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  @override
  Future<String> getCategoryById(String id) {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }

  @override
  Future<void> updateCategory(String id, CategoryModel category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }

}
