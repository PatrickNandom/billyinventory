import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeeContainer extends StatelessWidget {
  final Function()? function;
  final String containerName;
  const EmployeeContainer({
    super.key,
    required this.containerName,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            containerName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: function,
            child: SvgPicture.asset(
              'assets/arrow-down.svg',
              width: 20,
              height: 20,
            ),
          )
        ],
      ),
    );
  }
}
