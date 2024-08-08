import 'package:billyinventory/models/user_model.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get user details
  Stream<model.User?> userChanges() {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      // Return a stream with null to indicate no user is logged in
      return Stream<model.User?>.value(null);
    }

    return _firestore
        .collection('users')
        .doc(currentUser.uid)
        .snapshots()
        .map((snapshot) {
      // Check if the document exists before converting it
      if (snapshot.exists) {
        return model.User.fromSnap(snapshot);
      } else {
        // Handle the case where the user document doesn't exist
        return null;
      }
    });
  }

  // Sign Up User Function
  Future<model.User> signUpUser(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (password != confirmPassword) {
      throw Exception("Passwords do not match");
    }

    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(userCredential);

      model.User user = model.User(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        profileImage: '',
      );

      await _firestore.collection('users').doc(user.uid).set(user.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // Sign In User Function
  Future<model.User> signInUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      return model.User.fromSnap(userDoc);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // Sign In with Google Function
  Future<model.User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        throw Exception("Google sign-in failed or was cancelled");
      }
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final OAuthCredential cred = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(cred);

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      if (userDoc.exists) {
        return model.User.fromSnap(userDoc);
      } else {
        // If user does not exist in Firestore, create a new record
        model.User newUser = model.User(
          uid: userCredential.user!.uid,
          name: gUser.displayName ?? 'Unknown',
          email: gUser.email,
          profileImage: gUser.photoUrl ?? '',
        );
        await _firestore
            .collection('users')
            .doc(newUser.uid)
            .set(newUser.toJson());
        return newUser;
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // Sign Out User Function
  Future<void> signOutUser() async {
    await _firebaseAuth.signOut();
    // await GoogleSignIn().signOut();
  }
}
