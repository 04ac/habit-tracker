import 'package:flutter/material.dart';

class EnterHabitDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hintText;

  const EnterHabitDialog(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        decoration: InputDecoration(
          hintText: hintText,
        ),
        controller: controller,
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          child: const Text("Save"),
        ),
        MaterialButton(
          onPressed: onCancel,
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
