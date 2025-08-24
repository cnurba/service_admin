import 'package:service_admin/app/shop/units/domain/unit_model.dart';

abstract class IUnitRepository {
  /// Get all units.
  Future<List<UnitModel>> getAllUnits();
}
