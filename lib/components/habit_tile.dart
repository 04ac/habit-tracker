import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? onSettingsPress;
  final Function(BuildContext)? onDeletePress;

  const HabitTile(
      {super.key,
      required this.habitName,
      required this.habitCompleted,
      this.onChanged,
      this.onSettingsPress,
      this.onDeletePress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(16),
              backgroundColor: Colors.grey.shade800,
              onPressed: onSettingsPress,
              icon: Icons.settings,
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(16),
              backgroundColor: Colors.red.shade800,
              onPressed: onDeletePress,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Checkbox(value: habitCompleted, onChanged: onChanged),
              Text(habitName),
            ],
          ),
        ),
      ),
    );
  }
}
