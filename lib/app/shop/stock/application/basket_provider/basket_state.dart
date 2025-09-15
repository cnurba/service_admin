import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/stock/domain/models/income_basket_model.dart';
import 'package:service_admin/core/enums/state_type.dart';
import 'package:service_admin/core/presentation/errors/failure.dart';

class BasketState extends Equatable {
  final List<IncomeBasketModel> items;
  final StateType stateType;
  final String type;

  const BasketState({
    required this.items,
    required this.stateType,
    required this.type,
   });

  factory BasketState.initial() {
    return BasketState(
      items: [],
      stateType: StateType.initial,
      type: 'Приход',
        );
  }

  BasketState copyWith({
    List<IncomeBasketModel>? items,
    StateType? stateType,
    String? type,

  }) {
    return BasketState(
      items: items ?? this.items,
      stateType: stateType ?? this.stateType,
      type: type ?? this.type,
      );
  }

  @override
  List<Object?> get props => [items, stateType, type];
}
