import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_practice/firebase/authentication.dart';
import 'package:instagram_clone_practice/firebase/firestore_methods.dart';
import 'package:instagram_clone_practice/screens/login_screen.dart';
import 'package:instagram_clone_practice/utilities/colors.dart';
import 'package:instagram_clone_practice/utilities/utils.dart';
import 'package:instagram_clone_practice/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> profileData = {};
  bool gettingData = true;
  int following = 0;
  int followers = 0;
  int totalPosts = 0;
  bool isfollowing = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    try {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      profileData = snap.data() as Map<String, dynamic>;
      //Getting Posts Data
      var x = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();
      totalPosts = x.docs.length;
      isfollowing = profileData['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);

      followers = profileData['followers'].length;
      following = profileData['following'].length;

      setState(() {
        gettingData = false;
      });
    } catch (e) {
      displaySnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (gettingData) {
      return const Center(
        child: CircularProgressIndicator(
          color: blueColor,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(profileData['username']),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0).copyWith(bottom: 0.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(profileData['profilePhoto']),
                      radius: 40,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              getColumn('Posts', totalPosts),
                              getColumn('Followers', followers),
                              getColumn('Following', following),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FirebaseAuth.instance.currentUser!.uid ==
                                      widget.uid
                                  ? FollowButton(
                                      function: () async {
                                        await AuthorizationMethods().signOut();
                                        // ignore: use_build_context_synchronously
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return LoginScreen();
                                        }));
                                      },
                                      backgroundColor: mobileBackgroundColor,
                                      borderColor: Colors.grey,
                                      text: "Sign Out",
                                      textColor: primaryColor,
                                    )
                                  : isfollowing
                                      ? FollowButton(
                                          function: () async {
                                            await FirestoreMethods().followUser(
                                                uid: FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                followUserId: widget.uid);
                                            setState(() {
                                              isfollowing = false;
                                              followers--;
                                            });
                                          },
                                          backgroundColor: Colors.white,
                                          borderColor: Colors.grey,
                                          text: 'Unfollow',
                                          textColor: Colors.black)
                                      : FollowButton(
                                          function: () async {
                                            await FirestoreMethods().followUser(
                                                uid: FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                followUserId: widget.uid);
                                            setState(() {
                                              isfollowing = true;
                                              followers++;
                                            });
                                          },
                                          backgroundColor: blueColor,
                                          borderColor: Colors.blue,
                                          text: 'Follow',
                                          textColor: Colors.white,
                                        ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    profileData['username'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    profileData['bio'],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('posts')
                .where('uid', isEqualTo: widget.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: blueColor,
                  ),
                );
              }
              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 1.5,
                      childAspectRatio: 1),
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index].data();
                    return InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return PostCard(snap: data);
                        //     },
                        //   ),
                        // );
                      },
                      child: Container(
                        child: Image(
                          image: NetworkImage(
                            data['postUrl'],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  });
            },
          )
        ],
      ),
    );
  }

  Column getColumn(String label, int num) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
