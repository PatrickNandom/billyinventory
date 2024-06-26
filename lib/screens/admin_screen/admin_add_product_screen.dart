import 'dart:typed_data';

import 'package:billyinventory/common_widgets/my_custom_appbar.dart';
import 'package:billyinventory/common_widgets/my_custom_button.dart';
import 'package:billyinventory/screens/admin_screen/admin_widgets/admin_custom_text_input.dart';
import 'package:billyinventory/screens/admin_screen/admin_widgets/admin_text_input_style.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:billyinventory/utils/show_progress_indicator.dart';
import 'package:billyinventory/utils/snachbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final productKeyController = TextEditingController();
  final productNameController = TextEditingController();
  final productCostPriceController = TextEditingController();
  final productSellingPriceController = TextEditingController();
  final productQuantityController = TextEditingController();
  final producCategoryController = TextEditingController();
  final productDescriptionController = TextEditingController();

  Uint8List? _productImage;

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    productKeyController.dispose();
    productCostPriceController.dispose();
    productSellingPriceController.dispose();
    productQuantityController.dispose();
    producCategoryController.dispose();
    productDescriptionController.dispose();
  }

  Future<void> selectImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final Uint8List imageData = await image.readAsBytes();
      setState(() {
        _productImage = imageData;
      });
    }
  }

  void validation() {
    showProgressIndicator(context);

    if (productKeyController.text.isEmpty ||
        productNameController.text.isEmpty ||
        productCostPriceController.text.isEmpty ||
        productSellingPriceController.text.isEmpty ||
        productQuantityController.text.isEmpty ||
        producCategoryController.text.isEmpty ||
        productDescriptionController.text.isEmpty) {
      Navigator.pop(context);
      showSnackBar(context, 'Please fill in all fields and upload an image.');
      return;
    }

    if (_productImage == null || _productImage!.isEmpty) {
      Navigator.pop(context);
      showSnackBar(context, 'Please select an image.');
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      '/productpreview',
      arguments: {
        'productKey': productKeyController.text,
        'productName': productNameController.text,
        'productImage': _productImage!,
        'productDescription': productDescriptionController.text,
        'productCategory': producCategoryController.text,
        'productCostPrice': double.parse(productCostPriceController.text),
        'productSellingPrice': double.parse(productSellingPriceController.text),
        'productQuantity': int.parse(productQuantityController.text),
      },
    );
  }

  void displayDrawer() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: adminBackgroundColor,
      appBar: myCustomAppbar(displayDrawer),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add Products',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: SvgPicture.asset('assets/admin_x_icon.svg'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                LayoutBuilder(
                  builder: (context, constraints) {
                    double theWidth =
                        constraints.maxWidth < 307 ? constraints.maxWidth : 307;
                    double theHeight = constraints.maxHeight < 181
                        ? constraints.maxHeight
                        : 181;

                    return Container(
                      width: theWidth,
                      height: theHeight,
                      decoration: BoxDecoration(
                        border: Border.all(color: appColor, width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: _productImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.memory(
                                  _productImage!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Tap Upload Image',
                                  style: TextStyle(color: borderBlueColor),
                                ),
                              ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15.0),
                GestureDetector(
                  onTap: selectImage,
                  child: Container(
                    width: 144.0,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(width: 2.0, color: appColor)),
                    child: SvgPicture.asset('assets/upload_image.svg'),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Product Key',
                            style: TextStyle(
                              color: borderBlueColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          AdminTextFieldInput(
                            hintText: 'Enter Key',
                            textInputType: TextInputType.text,
                            textEditingController: productKeyController,
                            inputColor: borderBlueColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Product Name',
                            style: TextStyle(
                              color: borderBlueColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          AdminTextFieldInput(
                            hintText: 'Enter Name',
                            textInputType: TextInputType.text,
                            textEditingController: productNameController,
                            inputColor: borderBlueColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cost Price',
                            style: TextStyle(
                              color: borderBlueColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          AdminTextFieldInput(
                            hintText: 'Enter Cost Price',
                            textInputType: TextInputType.number,
                            textEditingController: productCostPriceController,
                            inputColor: borderBlueColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selling Price',
                            style: TextStyle(
                              color: borderBlueColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          AdminTextFieldInput(
                            hintText: 'Enter Selling Price',
                            textInputType: TextInputType.number,
                            textEditingController:
                                productSellingPriceController,
                            inputColor: borderBlueColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(
                              color: borderBlueColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          AdminTextFieldInput(
                            hintText: 'Enter Category',
                            textInputType: TextInputType.text,
                            textEditingController: producCategoryController,
                            inputColor: borderBlueColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Quantity',
                            style: TextStyle(
                              color: borderBlueColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          AdminTextFieldInput(
                            hintText: 'Enter Quantity',
                            textInputType: TextInputType.number,
                            textEditingController: productQuantityController,
                            inputColor: borderBlueColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        color: borderBlueColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: productDescriptionController,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white),
                        border: inputBorder,
                        focusedBorder: inputBorder,
                        enabledBorder: inputBorder,
                        filled: true,
                        fillColor: adminBackgroundColor, // Background color
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 45.0,
                          horizontal: 45.0,
                        ),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Center(
                      child: CustomButton(
                        function: validation,
                        backgroundColor: Colors.transparent,
                        borderColor: myGreenColor,
                        text: 'Next',
                        textColor: myGreenColor,
                        boderWidth: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
