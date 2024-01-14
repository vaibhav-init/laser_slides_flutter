import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String textToUse;
  final VoidCallback function;

  const CustomButton({
    Key? key,
    required this.function,
    required this.textToUse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.75;

    return ElevatedButton.icon(
      icon: const Icon(Icons.save),
      label: Text(
        textToUse,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      onPressed: function,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(buttonWidth, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
