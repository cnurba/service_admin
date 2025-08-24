import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/products/domain/models/new/new_product_model.dart';
import 'package:service_admin/core/enums/state_type.dart';

class NewProductState extends Equatable{
  final NewProductModel newProduct;
  final StateType stateType;
  final String? message;
  final String newProductId;

  const NewProductState({
    required this.newProduct,
    required this.stateType,
    this.message,
    this.newProductId = '',
  });

  factory NewProductState.initial() {
    return NewProductState(
      newProduct: NewProductModel.empty(),
      stateType: StateType.initial,
      message: null,
    );
  }

  copyWith({
    NewProductModel? newProduct,
    StateType? stateType,
    String? message,
    String? newProductId,
  }) {
    return NewProductState(
      newProduct: newProduct ?? this.newProduct,
      stateType: stateType ?? this.stateType,
      message: message ?? this.message,
      newProductId: newProductId ?? this.newProductId,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [newProduct, stateType, message,newProductId];
}