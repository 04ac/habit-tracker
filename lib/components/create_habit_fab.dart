import 'package:flutter/material.dart';

class CreateHabitFab extends StatelessWidget {
  final Function()? onPressed;
  const CreateHabitFab({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
