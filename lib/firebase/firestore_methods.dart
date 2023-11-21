import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:instagram_clone_practice/firebase/storage_functionalities.dart';
import 'package:instagram_clone_practice/models/post.dart';

import 'package:uuid/uuid.dart';

class FirestoreMethods {
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost(
    Uint8List image,
    String description,
    String username,
    String uid,
    String profilePicture,
  ) async {
    String res = "Some error has Occured";
    //  model.User user = Provider.of<UserProvider>(context).getUser;
    try {
      String postDownloadUrl =
          await StorageMethods().uploadImageToStorage(image, 'posts', true);
      String postId = Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        profilePhoto: profilePicture,
        username: username,
        postId: postId,
        postUrl: postDownloadUrl,
        datePublished: DateTime.now(),
        likes: [],
      );
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      await _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
