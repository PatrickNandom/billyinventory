import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdmingreyContainer extends StatelessWidget {
  final String containerTitle;
  final String topIconPath;
  final String bottomIconPath;
  final String rightContainerTile;
  final String rightContainerIconPath;
  final String rigtContainerPercentage;
  const AdmingreyContainer({
    super.key,
    required this.containerTitle,
    required this.topIconPath,
    required this.bottomIconPath,
    required this.rightContainerTile,
    required this.rightContainerIconPath,
    required this.rigtContainerPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth =
            constraints.maxWidth < 324.0 ? constraints.maxWidth : 327.0;
        double containerHeight =
            constraints.maxHeight < 140.0 ? constraints.maxHeight : 156.0;

        return Container(
          padding: const EdgeInsets.all(15),
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: greyContainerBackground,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: lightPurpleGrayColor,
                    ),
                    child: SvgPicture.asset(
                      topIconPath,
                    ),
                  ),
                  Text(
                    containerTitle,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    '....',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    color: lightPurpleGrayColor,
                    border: Border.all(
                      width: 2,
                      color: whiteColor,
                    ),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rightContainerTile,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      width: 48,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: appColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 7,
                            height: 3,
                            child: SvgPicture.asset(rightContainerIconPath),
                          ),
                          Text(
                            rigtContainerPercentage,
                            style: const TextStyle(
                                fontSize: 9, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
