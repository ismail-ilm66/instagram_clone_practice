import 'dart:typed_data';
import 'package:instagram_clone_practice/models/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:instagram_clone_practice/firebase/storage_functionalities.dart';

class AuthorizationMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUp({
    required String username,
    required String email,
    required String password,
    required String bio,
    required Uint8List image,
  }) async {
    String res = 'There is Some Error';
    try {
      if (username.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          // ignore: unnecessary_null_comparison
          image != null) {
        UserCredential credentials = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String dpUrl = await StorageMethods()
            .uploadImageToStorage(image, 'profilePics', false);

        model.User user = model.User(
          email: email,
          uid: credentials.user!.uid,
          profilePhoto: dpUrl,
          username: username,
          bio: bio,
          followers: [],
          following: [],
        );

        await _firestore.collection('users').doc(credentials.user!.uid).set(
              user.toJson(),
            );
        res = "Account Created";
        return res;
      }
    } catch (e) {
      print("Error: $e");
      res = e.toString();
    }
    return res;
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    String result = 'Some Error has occured';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = userCredential.user!.uid;
        result = "Successfully Logged In";
      } else {
        result = "Please Fill all the fields";
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }
}
