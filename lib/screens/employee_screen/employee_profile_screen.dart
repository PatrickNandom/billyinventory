import 'dart:typed_data';

import 'package:billyinventory/screens/employee_screen/employee_dashboard.dart';
import 'package:billyinventory/screens/employee_screen/emplyee_widgets/employee_custom_button.dart';
import 'package:billyinventory/screens/employee_screen/emplyee_widgets/employee_text_input.dart';
import 'package:billyinventory/services/storage_service.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:billyinventory/utils/show_progress_indicator.dart';
import 'package:billyinventory/utils/snachbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EmployeeSettingsScreen extends StatefulWidget {
  const EmployeeSettingsScreen({super.key});

  @override
  State<EmployeeSettingsScreen> createState() => _EmployeeSettingsScreenState();
}

class _EmployeeSettingsScreenState extends State<EmployeeSettingsScreen> {
  // Text editing controllers
  final _nameController = TextEditingController();
  final _confirmNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  Uint8List? _profileImage;

  //dispose functions

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _confirmNameController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    _passwordController.dispose();
    _confirmEmailController.dispose();
  }

//image picker function
  Future<void> selectImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final Uint8List imageData = await image.readAsBytes();
      setState(() {
        _profileImage = imageData;
      });
    }
  }

// function to update name
  Future<void> _updateName() async {
    showProgressIndicator(context);
    if (_nameController.text.isEmpty || _confirmNameController.text.isEmpty) {
      Navigator.pop(context);
      showSnackBar(context, 'Inputs cannot be empty');
      return;
    } else if (_nameController.text != _confirmNameController.text) {
      Navigator.pop(context);
      showSnackBar(context, 'Inputs supplied do not match!');
      return;
    }

    try {
      await FirebaseAuth.instance.currentUser!
          .updateDisplayName(_nameController.text);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'name': _nameController.text});
      Navigator.pop(context);
      showSnackBar(context, 'Name updated successfully');
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
  }

//function for user to change his email address
  Future<void> _updateEmail() async {
    showProgressIndicator(context);
    if (_emailController.text.isEmpty || _confirmEmailController.text.isEmpty) {
      Navigator.pop(context);
      print(_emailController.text);
      showSnackBar(context, 'Inputs cannot be empty!');
      return;
    } else if (_emailController.text != _confirmEmailController.text) {
      Navigator.pop(context);
      showSnackBar(context, 'Email supplied do not match');
      return;
    }
    try {
      await FirebaseAuth.instance.currentUser!
          // ignore: deprecated_member_use
          .updateEmail(_emailController.text);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'email': _emailController.text});
      Navigator.pop(context);
      showSnackBar(context, 'Email updated successfully');
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
  }

  // change password function
  Future<void> _updatePassword() async {
    showProgressIndicator(context);
    if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      Navigator.pop(context);
      showSnackBar(context, 'Fill the input fields');
      return;
    } else if (_passwordController.text != _confirmPasswordController.text) {
      Navigator.pop(context);
      showSnackBar(context, 'Passwords do not match!');
      return;
    }


    try {
      await FirebaseAuth.instance.currentUser!
          .updatePassword(_passwordController.text);
      Navigator.pop(context);
      showSnackBar(context, 'Password updated successfully');
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //upload a profile photo function
  Future<void> _uploadPicure() async {
    showProgressIndicator(context);
    if (_profileImage == null) {
      Navigator.pop(context);
      showSnackBar(context, 'Please select an image.');
      return;
    } else {
      try {
        String imageId = Uuid().v4();
        String imagePath = 'UserProfileImage/$imageId';
        String imageUrl = await FirebaseStorageService()
            .uploadImage(_profileImage!, 'User Image $imagePath');

        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'profileImage': imageUrl});
        Navigator.pop(context);
        showSnackBar(context, 'Image uploaded successfully');
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double btnWidth = MediaQuery.of(context).size.width;
    double theWidth = btnWidth > 500 ? 241 : btnWidth * 0.8;
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EmeployeeDashboard(),
                  ),
                );
              },
              child: SvgPicture.asset(
                'assets/arrow-left.svg',
                width: 30,
                height: 30,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            const Text(
              'Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Divider(
            thickness: 2,
            color: Colors.black,
          ),
          const SizedBox(
            width: 20,
          ),
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 231, 230, 230),
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: _profileImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.memory(
                                _profileImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            )
                          : Center(
                              child: Text(
                                '',
                                style: TextStyle(color: borderBlueColor),
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    left: 77,
                    child: GestureDetector(
                      onTap: selectImage,
                      child: SvgPicture.asset(
                        'assets/image_picker_icon.svg',
                        width: 15,
                        height: 15,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dev Patrick N...',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Welcome to your profile page...')
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Divider(
            thickness: 2,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    expandedAlignment: Alignment.center,
                    // title: Text(''),
                    title: Text(
                      'Change profile name',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.0,
                      ),
                    ),
                    children: [
                      EmployeeTextFieldInput(
                        textEditingController: _nameController,
                        hintText: 'Enter new name:',
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      EmployeeTextFieldInput(
                        textEditingController: _confirmNameController,
                        hintText: 'Confirm new name:',
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: theWidth,
                        child: EmployeeCustomButton(
                          function: _updateName,
                          backgroundColor: Colors.transparent,
                          borderColor: appColor,
                          text: 'Update Name',
                          textColor: appColor,
                          boderWidth: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    // title: Text(''),
                    expandedAlignment: Alignment.center,

                    title: Text(
                      'Change Email',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.0,
                      ),
                    ),
                    children: [
                      EmployeeTextFieldInput(
                        textEditingController: _emailController,
                        hintText: 'Email:',
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      EmployeeTextFieldInput(
                        textEditingController: _confirmEmailController,
                        hintText: 'Confirm Email:',
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: theWidth,
                        child: EmployeeCustomButton(
                          function: _updateEmail,
                          backgroundColor: Colors.transparent,
                          borderColor: appColor,
                          text: 'Update Email',
                          textColor: appColor,
                          boderWidth: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    expandedAlignment: Alignment.center,
                    title: Text(''),
                    leading: Text(
                      'Change password',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.0,
                      ),
                    ),
                    children: [
                      EmployeeTextFieldInput(
                        textEditingController: _passwordController,
                        hintText: 'Pasword:',
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      EmployeeTextFieldInput(
                        textEditingController: _confirmPasswordController,
                        hintText: 'Confirm Password:',
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: theWidth,
                        child: EmployeeCustomButton(
                          function: _updatePassword,
                          backgroundColor: Colors.transparent,
                          borderColor: appColor,
                          text: 'Update password',
                          textColor: appColor,
                          boderWidth: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: EmployeeCustomButton(
                    function: _uploadPicure,
                    backgroundColor: Colors.transparent,
                    boderWidth: 2,
                    borderColor: Colors.black,
                    text: 'Update photo',
                    textColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
