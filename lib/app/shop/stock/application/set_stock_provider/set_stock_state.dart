import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/stock/domain/models/set_stock_model.dart';
import 'package:service_admin/core/enums/state_type.dart';

class SetStockState extends Equatable {
  final List<SetStockModel> items;
  final StateType stateType;
  final String type;

  const SetStockState({
    required this.items,
    required this.stateType,
    this.type = 'set',
  });

  factory SetStockState.initial() {
    return SetStockState(items: [], stateType: StateType.initial);
  }

  SetStockState copyWith({
    List<SetStockModel>? items,
    StateType? stateType,
    String? type,
  }) {
    return SetStockState(
      items: items ?? this.items,
      stateType: stateType ?? this.stateType,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [items, stateType, type];
}
