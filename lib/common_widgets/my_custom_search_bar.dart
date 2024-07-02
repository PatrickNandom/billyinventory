// ignore: file_names
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final double searchContainerWidth;
  final double searchContainerHeight;
  final Color searchContainerBorderColor;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.searchContainerWidth,
    required this.searchContainerHeight,
    required this.searchContainerBorderColor,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double searchWidth = constraints.maxWidth < searchContainerWidth
          ? constraints.maxWidth
          : searchContainerWidth;
      double searchHeight = constraints.maxHeight < searchContainerHeight
          ? constraints.maxHeight
          : searchContainerHeight;

      return Container(
        // width: 299.0,
        // height: 37.0,
        width: searchWidth,
        height: searchHeight,

        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
            color: searchContainerBorderColor,
            width: 2,
          ),
        ),
        child: Center(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.black),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 6.0, horizontal: 15.0),
              suffixIcon: Icon(Icons.search, color: Colors.black),
            ),
          ),
        ),
      );
    });
  }
}
