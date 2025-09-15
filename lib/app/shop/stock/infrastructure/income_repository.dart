import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:service_admin/app/shop/stock/application/basket_provider/basket_state.dart';
import 'package:service_admin/app/shop/stock/domain/models/income_model.dart';
import 'package:service_admin/app/shop/stock/domain/repositories/i_income_repository.dart';
import 'package:service_admin/core/http/endpoints.dart';
import 'package:service_admin/core/presentation/errors/failure.dart';

class IncomeRepository implements IIncomeRepository {
  final Dio _dio;

  IncomeRepository(this._dio);

  @override
  Future<FailureModel> post(BasketState state, String type) async {
    try {
      final data = state.items.map((e) => e.toJson()).toList();
      final result = await _dio.post(
        Endpoints.income.income,
        data: {"items": data},
        queryParameters: {"type": type},
      );
      return FailureModel.fromJson(result.data);
    } catch (e) {
      log("Error sending stocks: $e");
      return FailureModel.error(e.toString());
    }
  }

  @override
  Future<List<IncomeModel>> getProductsWithAttributes() async {
    try {
      final response = await _dio.get(Endpoints.income.income);
      final List<dynamic> data = response.data;
      return data.map((json) => IncomeModel.fromJson(json)).toList();
    } catch (e) {
      log("Error fetching products with attributes: $e");
      return [];
    }
  }
}
