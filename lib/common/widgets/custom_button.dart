import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String textToUse;
  final VoidCallback function;
  const CustomButton({
    super.key,
    required this.function,
    required this.textToUse,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.save),
      label: Text(textToUse),
      onPressed: function,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }
}
