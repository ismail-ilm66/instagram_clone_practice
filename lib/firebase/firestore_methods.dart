import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_practice/models/user.dart' as model;
import 'package:instagram_clone_practice/providers/user_provider.dart';
import 'package:provider/provider.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost(BuildContext context) async {
    String res = "Some error has Occured";
    model.User user = Provider.of<UserProvider>(context).getUser;
    try {
      //_firestore.collection('posts').doc(user.uid).set({''})
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
