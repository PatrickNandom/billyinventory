import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButtonGlobal extends StatelessWidget {
  final Function()? function;
  final double width;
  final double height;
  final String name;
  final Widget widgetName;

  const CustomButtonGlobal({
    super.key,
    this.function,
    required this.width,
    required this.height,
    required this.name,
    required this.widgetName,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double buttonWidth =
          constraints.maxWidth < width ? constraints.maxWidth : width;
      double buttonHeight =
          constraints.maxHeight < height ? constraints.maxHeight : height;

      return GestureDetector(
        onTap: function,
        child: Container(
          padding: const EdgeInsets.all(5),
          width: buttonWidth,
          height: buttonHeight,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.white, width: 1.0),
            boxShadow: const [
              BoxShadow(
                color: appColor,
                offset: Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: widgetName,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                name,
                style: const TextStyle(
                  color: whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
