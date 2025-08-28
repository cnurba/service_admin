import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:service_admin/core/http/endpoints.dart';
import '../domain/model/price_model.dart';

class PriceService {
  final Dio dio;

  PriceService({required this.dio});

  Future<void> sendPricesToServer(
    List<PriceModel> products,
    Map<String, int> newPrices,
    Map<String, String> newPricesType,
    BuildContext context,
  ) async {
    final List<Map<String, dynamic>> payload = [];

    newPrices.forEach((uuid, myPrice) {
      final product = products.firstWhere((p) => p.productUuid == uuid);
      final type = newPricesType[uuid] ?? 'Оптовый';

      payload.add({
        'productUuid': product.productUuid,
        'type': type,
        'myPrice': myPrice,
        'basePrice': type == 'Оптовый'
            ? product.wholesalePrice
            : product.retailPrice,
      });
    });

    try {
      final response = await dio.post(
        "${Endpoints.product.products}/update_prices", // adjust if needed
        data: payload,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Prices updated successfully on server!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update prices: ${response.data}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
