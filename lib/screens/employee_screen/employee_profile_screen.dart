
import 'package:billyinventory/screens/employee_screen/employee_dashboard.dart';
import 'package:billyinventory/screens/employee_screen/emplyee_widgets/employee_text_input.dart';
import 'package:billyinventory/screens/employee_screen/emplyee_widgets/emplyee_container.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeeSettingsScreen extends StatefulWidget {
  const EmployeeSettingsScreen({super.key});

  @override
  State<EmployeeSettingsScreen> createState() => _EmployeeSettingsScreenState();
}

class _EmployeeSettingsScreenState extends State<EmployeeSettingsScreen> {
  // Text editing controllers
  final _nameController = TextEditingController();
  final _devNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //dispose functions

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _devNameController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    _passwordController.dispose();
    _confirmEmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EmeployeeDashboard()));
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
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: whiteColor,
                border: Border(
                    top: BorderSide(color: Colors.black, width: 2),
                    bottom: BorderSide(color: Colors.black, width: 2))),
            child: Row(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: backgroundColor,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1717457781885-d1cd3ede18e3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8',
                      ),
                    ),
                    Positioned(
                      left: 67,
                      child: GestureDetector(
                        onTap: () {},
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
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                EmployeeContainer(
                  containerName: 'Change profile name',
                  function: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                EmployeeTextFieldInput(
                  textEditingController: _nameController,
                  hintText: 'Profile:',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                EmployeeTextFieldInput(
                  textEditingController: _devNameController,
                  hintText: 'Display name:',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Opacity(
                      opacity: 1,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/employee_background_image.svg',
                          width: 100,
                          height: 230,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(1),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          EmployeeContainer(
                            containerName: 'Change Email',
                            function: () {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          EmployeeTextFieldInput(
                            textEditingController: _emailController,
                            hintText: 'Email:',
                            textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          EmployeeTextFieldInput(
                            textEditingController: _confirmEmailController,
                            hintText: 'Confirm email:',
                            textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          EmployeeContainer(
                            containerName: 'Change Password',
                            function: () {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          EmployeeTextFieldInput(
                            textEditingController: _passwordController,
                            hintText: 'Password:',
                            textInputType: TextInputType.text,
                            isPass: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          EmployeeTextFieldInput(
                            textEditingController: _confirmPasswordController,
                            hintText: 'Confirm password:',
                            textInputType: TextInputType.text,
                            isPass: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




//profile page for employee

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';

// class EmployeeSettingsScreen extends StatefulWidget {
//   const EmployeeSettingsScreen({super.key});

//   @override
//   State<EmployeeSettingsScreen> createState() => _EmployeeSettingsScreenState();
// }

// class _EmployeeSettingsScreenState extends State<EmployeeSettingsScreen> {
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _confirmEmailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _confirmEmailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   Future<void> _updateName() async {
//     if (_nameController.text.isNotEmpty) {
//       await FirebaseAuth.instance.currentUser!.updateDisplayName(_nameController.text);
//       await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'name': _nameController.text});
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Name updated successfully')));
//     }
//   }

//   Future<void> _updateEmail() async {
//     if (_emailController.text.isNotEmpty && _emailController.text == _confirmEmailController.text) {
//       await FirebaseAuth.instance.currentUser!.updateEmail(_emailController.text);
//       await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'email': _emailController.text});
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email updated successfully')));
//     }
//   }

//   Future<void> _updatePassword() async {
//     if (_passwordController.text.isNotEmpty && _passwordController.text == _confirmPasswordController.text) {
//       await FirebaseAuth.instance.currentUser!.updatePassword(_passwordController.text);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password updated successfully')));
//     }
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       final file = File(pickedFile.path);
//       final storageRef = FirebaseStorage.instance.ref().child('profile_pictures/${FirebaseAuth.instance.currentUser!.uid}.jpg');
//       await storageRef.putFile(file);
//       final imageUrl = await storageRef.getDownloadURL();
//       await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'profilePicture': imageUrl});
//       setState(() {});
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile picture updated successfully')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Row(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//               child: SvgPicture.asset(
//                 'assets/arrow-left.svg',
//                 width: 30,
//                 height: 30,
//               ),
//             ),
//             const SizedBox(width: 30),
//             const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Stack(
//                   children: [
//                     CircleAvatar(
//                       radius: 45,
//                       backgroundColor: Colors.grey.shade200,
//                       backgroundImage: NetworkImage(
//                         'https://images.unsplash.com/photo-1717457781885-d1cd3ede18e3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8',
//                       ),
//                     ),
//                     Positioned(
//                       left: 67,
//                       child: GestureDetector(
//                         onTap: _pickImage,
//                         child: SvgPicture.asset(
//                           'assets/image_picker_icon.svg',
//                           width: 15,
//                           height: 15,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(width: 20),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Dev Patrick N...', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
//                     Text('Welcome to your profile page...')
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             EmployeeTextFieldInput(
//               textEditingController: _nameController,
//               hintText: 'Profile Name:',
//               textInputType: TextInputType.text,
//             ),
//             ElevatedButton(onPressed: _updateName, child: const Text('Update Name')),
//             const SizedBox(height: 10),
//             EmployeeTextFieldInput(
//               textEditingController: _emailController,
//               hintText: 'Email:',
//               textInputType: TextInputType.emailAddress,
//             ),
//             EmployeeTextFieldInput(
//               textEditingController: _confirmEmailController,
//               hintText: 'Confirm Email:',
//               textInputType: TextInputType.emailAddress,
//             ),
//             ElevatedButton(onPressed: _updateEmail, child: const Text('Update Email')),
//             const SizedBox(height: 10),
//             EmployeeTextFieldInput(
//               textEditingController: _passwordController,
//               hintText: 'Password:',
//               textInputType: TextInputType.text,
//               isPass: true,
//             ),
//             EmployeeTextFieldInput(
//               textEditingController: _confirmPasswordController,
//               hintText: 'Confirm Password:',
//               textInputType: TextInputType.text,
//               isPass: true,
//             ),
//             ElevatedButton(onPressed: _updatePassword, child: const Text('Update Password')),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EmployeeTextFieldInput extends StatelessWidget {
//   final TextEditingController textEditingController;
//   final String hintText;
//   final TextInputType textInputType;
//   final bool isPass;

//   const EmployeeTextFieldInput({
//     required this.textEditingController,
//     required this.hintText,
//     required this.textInputType,
//     this.isPass = false,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: textEditingController,
//       decoration: InputDecoration(hintText: hintText),
//       keyboardType: textInputType,
//       obscureText: isPass,
//     );
//   }
// }
