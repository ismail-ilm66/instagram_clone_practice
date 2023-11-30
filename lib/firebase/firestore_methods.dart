import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:instagram_clone_practice/firebase/storage_functionalities.dart';
import 'package:instagram_clone_practice/models/post.dart';

import 'package:uuid/uuid.dart';

class FirestoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
      await _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(
      {required String uid,
      required String postId,
      required List likes}) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update(
          {
            'likes': FieldValue.arrayRemove([uid]),
          },
        );
      } else {
        await _firestore.collection('posts').doc(postId).update(
          {
            'likes': FieldValue.arrayUnion([uid]),
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
