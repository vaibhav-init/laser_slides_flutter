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
      icon: const Icon(
        Icons.save,
        color: Colors.black,
      ),
      label: Text(
        textToUse,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),
      ),
      onPressed: function,
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          color: Colors.black,
        ),
        backgroundColor: Colors.red.withOpacity(0.9),
        minimumSize: Size(buttonWidth, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
