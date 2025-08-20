import 'package:equatable/equatable.dart';
import 'package:service_admin/app/shop/categories/domain/models/category_model.dart';
import 'package:service_admin/core/enums/state_type.dart';

class NewCategoryState extends Equatable {
  final CategoryModel category;
  final StateType stateType;

  const NewCategoryState({required this.category, required this.stateType});

  factory NewCategoryState.initial() {
    return NewCategoryState(
      category: CategoryModel.empty(),
      stateType: StateType.initial,
    );
  }

  NewCategoryState copyWith({CategoryModel? category, StateType? stateType}) {
    return NewCategoryState(
      category: category ?? this.category,
      stateType: stateType ?? this.stateType,
    );
  }

  @override
  List<Object?> get props => [category, stateType];
}
