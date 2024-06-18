// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';

// Future<String> uploadImage(File imageFile, String imageName) async {
//   try {
//     // Generate a unique file name for the image
//     final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//     // final Reference storageRef = storage.ref().child(imageName).child(fileName);

//     // Upload the image file to Firebase Storage
//     await storageRef.putFile(imageFile);

//     // Get the download URL of the uploaded image
//     final String downloadURL = await storageRef.getDownloadURL();

//     return downloadURL;
//   } catch (e) {
//     print('Error uploading image: $e');
//     return '';
//   }
// }
