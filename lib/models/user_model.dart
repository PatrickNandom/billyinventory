import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String profileImage;
  bool isAdmin;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileImage,
    this.isAdmin = false,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot["uid"],
      name: snapshot["name"],
      email: snapshot["email"],
      profileImage: snapshot["profileImage"],
      isAdmin: snapshot["isAdmin"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "profileImage": profileImage,
        "isAdmin": isAdmin,
      };
}
