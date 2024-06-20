// ignore_for_file: use_build_context_synchronously

import 'package:billyinventory/common_widgets/my_custom_button.dart';
import 'package:billyinventory/common_widgets/my_custom_text_field_input.dart';
import 'package:billyinventory/models/user_model.dart';
import 'package:billyinventory/screens/dashboard.dart';
import 'package:billyinventory/screens/signup_screen.dart';
import 'package:billyinventory/services/auth_service.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:billyinventory/utils/show_progress_indicator.dart';
import 'package:billyinventory/utils/snachbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

//Initializing the AuthService class
  final AuthService _authService = AuthService();

  // The dispose function
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

// Login Function
  void _signIn() async {
    showProgressIndicator(context);
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      Navigator.pop(context);
      showSnackBar(context, 'Please fill all fields');
      return;
    }

    try {
      User? user = await _authService.signInUser(
          _emailController.text, _passwordController.text);
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage(user: user)),
      );
        } catch (e) {
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/app_icon.svg',
                width: 100,
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                  width: double.infinity,
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
                      SvgPicture.asset(
                        'assets/sign_in.svg',
                        width: 74,
                        height: 34,
                      ),
                      const SizedBox(
                        height: 30,
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
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/green_group.svg',
                              width: 15,
                              height: 15,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const Text(
                              'Keep me Login.',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        backgroundColor: appColor,
                        borderColor: appColor,
                        text: 'Login',
                        textColor: whiteColor,
                        function: _signIn,
                        boderWidth: 0,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgoten password?',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        backgroundColor: backgroundColor,
                        borderColor: appColor,
                        text: 'Create new account',
                        textColor: appColor,
                        function: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ),
                          );
                        },
                        boderWidth: 2,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
