import 'package:billyinventory/screens/admin_screen/admin_widgets/custom_button_with_arrow.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';

class MyBlueContainer extends StatelessWidget {
  final String containerTitle;
  final String containerValue;
  final String containerPercentage;
  final Color btnBgColor;
  final Color btnBorderColor;
  final Function()? function;

  const MyBlueContainer({
    super.key,
    required this.containerTitle,
    required this.containerValue,
    required this.containerPercentage,
    required this.btnBgColor,
    required this.btnBorderColor,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine the size to use based on the available space
        double containerWidth =
            constraints.maxWidth < 324.0 ? constraints.maxWidth : 324.0;
        double containerHeight =
            constraints.maxHeight < 140.0 ? constraints.maxHeight : 140.0;

        return Container(
          padding: const EdgeInsets.all(15),
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.4541, 0.9735],
              colors: [semiTransparentBlue, semiTransparentDarkBlue],
            ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      containerTitle,
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      containerValue,
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: 21,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      containerPercentage,
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 35,
                height: 42,
                child: GestureDetector(
                  onTap: function,
                  child: CustomButtonWithArrow(
                    buttonBackgroundColor: btnBgColor,
                    borderColor: btnBorderColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
