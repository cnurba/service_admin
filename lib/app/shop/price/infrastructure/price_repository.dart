import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:service_admin/app/shop/price/domain/model/price_model.dart';
import 'package:service_admin/app/shop/price/domain/model/price_type_model.dart';
import 'package:service_admin/app/shop/price/domain/repositories/i_price_repository.dart';

class PriceRepository implements IPriceRepository {
  final Dio _dio;
  PriceRepository(this._dio);

  @override
  Future<List<PriceTypeModel>> getPriceTypes() async {
    final response = await _dio.get("/priceTypes");
    return (response.data as List)
        .map((json) => PriceTypeModel.fromJson(json))
        .toList();
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
}
