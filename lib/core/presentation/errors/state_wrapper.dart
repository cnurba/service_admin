import 'package:flutter/material.dart';
import 'package:service_admin/core/enums/state_type.dart';

class StateWrapper extends StatelessWidget {
  final StateType stateType;
  final Widget child;
  final Widget? errorChild;
  final VoidCallback? onSuccess;

  const StateWrapper({
    super.key,
    required this.stateType,
    required this.child,
    this.errorChild,
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    switch (stateType) {
      case StateType.initial:
        return child;
      case StateType.loading:
        return Center(child: CircularProgressIndicator());
      case StateType.success:
        if (onSuccess != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onSuccess!();
          });
        }

        return child;
      case StateType.error:
        return errorChild ?? Center(child: Text('Произошла ошибка'));
      default:
        return Center(child: Text('Неизвестное состояние'));
    }
  }
}
