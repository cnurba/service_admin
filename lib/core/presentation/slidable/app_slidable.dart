import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
/// A reusable slidable widget for list items with delete action
/// This widget can be used to wrap any child widget and provide a sliding action to delete the item.
class AppSlidable extends StatelessWidget {
  const AppSlidable({super.key, required this.id, required this.child, this.onDelete});

  final String id;
  final Widget child;
  final Function(BuildContext)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: child,
    );
  }
}
