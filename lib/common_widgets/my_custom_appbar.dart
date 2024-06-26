import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar myCustomAppbar(Function()? function) {
  return AppBar(
    backgroundColor: adminBackgroundColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: function,
          child: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset(
              // ignore: deprecated_member_use
              color: Colors.transparent,
              'assets/admin_menu.svg',
            ),
          ),
        ),
        const Text(
          'Billy Inventory',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: appColor,
          ),
        ),
        SizedBox(
          width: 35,
          height: 35,
          child: SvgPicture.asset(
            'assets/app_icon.svg',
          ),
        ),
      ],
    ),
  );
}
