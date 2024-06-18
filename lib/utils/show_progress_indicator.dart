import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';
showProgressIndicator(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(
        backgroundColor: backgroundColor,
        color: appColor,
      ),
    ),
  );
}
