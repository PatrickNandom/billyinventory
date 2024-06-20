import 'package:flutter/material.dart';

class CustomButtonWithArrow extends StatelessWidget {
  final Color buttonBackgroundColor;
  final Color borderColor;
  const CustomButtonWithArrow({
    super.key,
    required this.borderColor,
    required this.buttonBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 42,
      decoration: BoxDecoration(
        color: buttonBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: const Center(
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
