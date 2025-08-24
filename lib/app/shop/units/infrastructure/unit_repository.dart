import 'package:dio/dio.dart';
import 'package:service_admin/app/shop/units/domain/i_unit_repository.dart';
import 'package:service_admin/app/shop/units/domain/unit_model.dart';

class UnitRepository implements IUnitRepository{
  final Dio _dio;
  UnitRepository(this._dio);

  @override
  Future<List<UnitModel>> getAllUnits() async {
    try {
      final responseData = await _dio.get('/units');
      if (responseData.statusCode == 200) {
        final unitsList = (responseData.data as List)
            .map((unit) => UnitModel.fromJson(unit))
            .toList();
        return unitsList;
      } else {
        throw Exception('Failed to load units');
      }
    } catch (e) {
      throw Exception('Error fetching units: $e');
    }
  }


}