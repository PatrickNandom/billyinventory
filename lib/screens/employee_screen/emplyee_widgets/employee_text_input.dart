import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeeTextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;

  const EmployeeTextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    const inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
        color: appColor,
        width: 2.0,
      ),
    );

    // Calculate width based on screen size for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double inputWidth = screenWidth > 500 ? 241 : screenWidth * 0.8;

    return SizedBox(
      width: inputWidth,
      child: SizedBox(
        height: 30,
        child: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: SizedBox(
                width: 6,
                height: 6,
                child: SvgPicture.asset(
                  'assets/edit_icon.svg',
                ),
              ),
            ),
            hintText: hintText,
            border: inputBorder,
            focusedBorder: inputBorder,
            enabledBorder: inputBorder,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 15.0,
            ),
          ),
          keyboardType: textInputType,
          obscureText: isPass,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
