import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:service_admin/app/shop/brands/domain/models/brand_model.dart';
import 'package:service_admin/app/shop/brands/domain/repositories/i_brand_repository.dart';
import 'package:service_admin/app/shop/brands/infrastructure/dtos/brand_dto.dart';
import 'package:service_admin/core/http/endpoints.dart';

class BrandRepository implements IBrandRepository {
  final Dio _dio;

  BrandRepository(this._dio);

  @override
  Future<bool> addBrand(BrandModel brand) async {
    try {
      log("START NEW BRAND MODEL REQUEST");
      final brandData = BrandDto.fromBrand(brand).toJson();
      final responseData = await _dio.post(
        Endpoints.brands.brands,
        data: brandData,
      );
      log("FINISH BRAND MODEL ${responseData.data}");
      return true;
    } catch (e) {
      log("Error fetching objects: $e");
      return false;
    }
  }

  @override
  Future<void> deleteBrand(String id) {
    // TODO: implement deleteBrand
    throw UnimplementedError();
  }

  @override
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final responseData = await _dio.get(Endpoints.brands.brands);
      if (responseData.statusCode == 200) {
        final brandsList = (responseData.data as List)
            .map((brands) => BrandDto.fromJson(brands).toBrand())
            .toList();
        log("FINISH Brand length  ${brandsList.length}");
        return brandsList;
      } else {
        throw Exception('Failed to load brands');
      }
    } catch (e) {
      throw Exception('Error fetching brands: $e');
    }
  }

  @override
  Future<String> getBrandById(String id) {
    // TODO: implement getBrandById
    throw UnimplementedError();
  }

  @override
  Future<void> updateBrand(String id, BrandModel brand) {
    // TODO: implement updateBrand
    throw UnimplementedError();
  }
}
