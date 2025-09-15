import 'package:flutter/material.dart';
import 'package:service_admin/core/enums/state_type.dart';

class StateAnimatedIcon extends StatelessWidget {
  const StateAnimatedIcon({super.key, required this.stateType, this.onTap});

  final StateType stateType;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    /// Create animated icon that changes based on [StateType] state
    /// [StateType] has initial, loading, success, error states
    /// Use AnimatedSwitcher to switch between icons
    /// Use Icons.upload for initial.
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: stateType == StateType.initial
          ? IconButton(
              key: const ValueKey('initial'),
              icon: const Icon(Icons.upload),
              onPressed: onTap,
              tooltip: 'Сохранить',
            )
          : stateType == StateType.loading
          ? IconButton(
              key: const ValueKey('loading'),
              icon: const Icon(Icons.donut_large_rounded),
              onPressed: onTap,
              tooltip: 'Сохранить',
            )
          : stateType == StateType.success
          ? const Icon(
              key: ValueKey('success'),
              Icons.check_circle,
              color: Colors.white,
            )
          : stateType == StateType.error
          ? const Icon(key: ValueKey('error'), Icons.error, color: Colors.red)
          : const SizedBox(key: ValueKey('empty')),
    );
  }
}
