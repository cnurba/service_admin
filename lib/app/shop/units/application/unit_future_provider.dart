import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/units/domain/i_unit_repository.dart';
import 'package:service_admin/app/shop/units/domain/unit_model.dart';
import 'package:service_admin/app/shop/units/infrastructure/unit_repository.dart';
import 'package:service_admin/injection.dart';


final unitRepositoryProvider = Provider<IUnitRepository>(
      (ref) => UnitRepository(getIt<Dio>()),
);

final unitFutureProvider = FutureProvider<List<UnitModel>>((ref) async {
  return ref.read(unitRepositoryProvider).getAllUnits();
});
