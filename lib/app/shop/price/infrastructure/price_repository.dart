import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:service_admin/app/shop/price/application/set_price_provider/set_price_state.dart';
import 'package:service_admin/app/shop/price/domain/model/price_model.dart';
import 'package:service_admin/app/shop/price/domain/model/price_type_model.dart';
import 'package:service_admin/app/shop/price/domain/repositories/i_price_repository.dart';

class PriceRepository implements IPriceRepository {
  final Dio _dio;

  PriceRepository(this._dio);

  @override
  Future<List<PriceTypeModel>> getPriceTypes() async {
    try {
      log('START price types');
      final response = await _dio.get("/priceTypes");

      final List<PriceTypeModel> priceTypes = (response.data as List)
          .map((json) => PriceTypeModel.fromJson(json))
          .toList();
      log('Fetched ${priceTypes.length} price types');

      return priceTypes;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch price types");
    }
  }

  @override
  Future<List<PriceModel>> getPricesByType(String priceTypeUuid) async {
    try {
      final response = await _dio.get(
        "/prices",
        queryParameters: {"priceTypeUuid": priceTypeUuid},
      );
      return (response.data as List)
          .map((json) => PriceModel.fromJson(json))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception("priceTypeUuid must be a valid integer string");
    }
  }

  @override
  Future<bool> setPrices(SetPriceState state) async {
    try {
      final response = await _dio.post("/prices", data: state.toJson());
      return response.statusCode == 200;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
