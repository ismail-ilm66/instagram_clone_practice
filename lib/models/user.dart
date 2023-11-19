import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String profilePhoto;
  final String username;
  final String bio;
  final List followers;
  final List following;

  User(
      {required this.email,
      required this.uid,
      required this.profilePhoto,
      required this.username,
      required this.bio,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'profilePhoto': profilePhoto,
        'username': username,
        'bio': bio,
        'followers': followers,
        'following': following,
      };
  static User fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> x = snapshot.data() as Map<String, dynamic>;
    return User(
      email: x['email'],
      uid: x['uid'],
      profilePhoto: x['profilePhoto'],
      username: x['username'],
      bio: x['bio'],
      followers: x['followers'],
      following: x['following'],
    );
  }
}
