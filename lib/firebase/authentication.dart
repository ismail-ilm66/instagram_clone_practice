import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

        await _firestore.collection('users').doc(credentials.user!.uid).set(
          {
            'username': username,
            "bio": bio,
            "uid": credentials.user!.uid,
            'email': email,
            'followers': [],
            'following': [],
            'profilePhoto': dpUrl,
          },
        );
        res = "Account Created";
        return res;
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
