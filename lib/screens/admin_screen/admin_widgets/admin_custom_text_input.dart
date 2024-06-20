import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminTextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Color? inputColor;

  const AdminTextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    this.inputColor,
  });

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder inputBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: inputColor ?? appColor,
        width: 2.0,
      ),
    );

    return SizedBox(
      height: 30.0,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:TextStyle(color: whiteColor),
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          fillColor: adminBackgroundColor, // White background color
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: 15.0,
          ),
        ),
        keyboardType: textInputType,
        obscureText: isPass,
      ),
    );
  }
}
