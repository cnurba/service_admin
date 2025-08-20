import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/brands/domain/models/brand_model.dart';
import 'package:service_admin/core/enums/state_type.dart';

class NewBrandState extends Equatable {
  final BrandModel brand;
  final StateType stateType;

  const NewBrandState({required this.brand, required this.stateType});

  factory NewBrandState.initial() {
    return NewBrandState(
      brand: BrandModel.empty(),
      stateType: StateType.initial,
    );
  }

  NewBrandState copyWith({BrandModel? brand, StateType? stateType}) {
    return NewBrandState(
      brand: brand ?? this.brand,
      stateType: stateType ?? this.stateType,
    );
  }

  @override
  List<Object?> get props => [brand, stateType];
}
