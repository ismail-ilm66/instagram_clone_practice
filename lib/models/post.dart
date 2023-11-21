import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String profilePhoto;
  final String username;
  final String postId;
  final String postUrl;
  final datePublished;
  final List likes;

  Post({
    required this.description,
    required this.uid,
    required this.profilePhoto,
    required this.username,
    required this.postId,
    required this.postUrl,
    required this.datePublished,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'profilePhoto': profilePhoto,
        'username': username,
        'postId': postId,
        'postUrl': postUrl,
        'datePublished': datePublished,
        'likes': likes,
      };
  static Post fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> x = snapshot.data() as Map<String, dynamic>;
    return Post(
      description: x['description'],
      uid: x['uid'],
      profilePhoto: x['profilePhoto'],
      username: x['username'],
      postId: x['postId'],
      postUrl: x['postUrl'],
      datePublished: x['datePublished'],
      likes: x['likes'],
    );
  }
}
