// ignore_for_file: use_build_context_synchronously

import 'package:billyinventory/common_widgets/my_custom_button.dart';
import 'package:billyinventory/common_widgets/my_custom_text_field_input.dart';
import 'package:billyinventory/screens/dashboard.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:billyinventory/utils/show_progress_indicator.dart';
import 'package:billyinventory/utils/snachbar.dart';

import '../services/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //  text editing controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

// initialising AuthService class
  final AuthService _authService = AuthService();

  // the dispose method
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  void _signUp() async {
    showProgressIndicator(context);

    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      Navigator.pop(context);
      showSnackBar(context, 'Please fill all fields');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      Navigator.pop(context);
      showSnackBar(context, 'Passwords do not match');
      return;
    }

    try {
      var user = await _authService.signUpUser(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _confirmPasswordController.text,
      );
      // ignore: unnecessary_null_comparison
      if (user != null) {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage(user: user)),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
  }

  // Google sign in

  void _signInWithGoogle() async {
    try {
      showProgressIndicator(context);
      var user = await _authService.signInWithGoogle();
      if (user != null) {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage(user: user)),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100.0,
                ),
                SvgPicture.asset(
                  'assets/app_icon.svg',
                  width: 100,
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 40,
                      right: 20,
                      bottom: 40,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Create an account',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'Enter your details to signup for this app',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldInput(
                          textEditingController: _nameController,
                          hintText: 'Name:',
                          isPass: false,
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldInput(
                          textEditingController: _emailController,
                          hintText: 'Email:',
                          isPass: false,
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldInput(
                          textEditingController: _passwordController,
                          hintText: 'Password:',
                          isPass: true,
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldInput(
                          textEditingController: _confirmPasswordController,
                          hintText: 'Confirm Password:',
                          isPass: true,
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          backgroundColor: appColor,
                          borderColor: whiteColor,
                          text: 'SignUp',
                          textColor: whiteColor,
                          function: _signUp,
                          boderWidth: 1,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          '-------------or continue with----------------',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: _signInWithGoogle,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/Google.svg',
                                  width: 20,
                                  height: 20,
                                ),

                                // const SizedBox(
                                //   width: 100,
                                // ),
                                const Expanded(
                                  child: Center(
                                    child: Text(
                                      'Google',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'By clicking continue, you agree to our ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Terms of Service ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )),
                              TextSpan(
                                  text: 'and ',
                                  style: TextStyle(color: Colors.grey)),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
