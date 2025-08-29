import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/price/domain/model/set_price_model.dart';
import 'package:service_admin/core/enums/state_type.dart';

import '../../domain/model/price_model.dart';

class SetPriceState extends Equatable {
  final String priceTypeUuid;
  final List<SetPriceModel> items;
  final StateType stateType;

  const SetPriceState({
    required this.priceTypeUuid,
    required this.items,
    required this.stateType,
  });

  factory SetPriceState.initial() {
    return const SetPriceState(
      priceTypeUuid: '',
      items: [],
      stateType: StateType.initial,
    );
  }

  List<PriceModel> get priceModels => items.map((e) => e.priceModel).toList();

  SetPriceState copyWith({
    String? priceTypeUuid,
    List<SetPriceModel>? items,
    StateType? stateType,
  }) {
    return SetPriceState(
      priceTypeUuid: priceTypeUuid ?? this.priceTypeUuid,
      items: items ?? this.items,
      stateType: stateType ?? this.stateType,
    );
  }

  toJson() {
    return {
      'priceTypeUuid': priceTypeUuid,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [priceTypeUuid, items, stateType];
}
