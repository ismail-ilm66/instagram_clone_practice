import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_practice/firebase/firestore_methods.dart';
import 'package:instagram_clone_practice/providers/user_provider.dart';
import 'package:instagram_clone_practice/utilities/colors.dart';
import 'package:instagram_clone_practice/utilities/utils.dart';
import 'package:instagram_clone_practice/widgets/comment_card.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key, required this.snapshot});
  final TextEditingController controller = TextEditingController();
  final snapshot;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: const Text('Comments'),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          // color: Colors.white,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.profilePhoto),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Comment As ${user.username}',
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    if (controller.text.isNotEmpty) {
                      await FirestoreMethods().postComments(
                        controller.text,
                        user.uid,
                        user.profilePhoto,
                        snapshot['postId'],
                        user.username,
                      );
                      controller.clear();
                    } else {
                      displaySnackBar(context, 'Please Enter the comment');
                    }
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(snapshot['postId'])
            .collection('comments')
            .orderBy('date')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return CommentsCard(snapshot: snapshot.data!.docs[index].data());
            },
          );
        },
      ),
    );
  }
}
