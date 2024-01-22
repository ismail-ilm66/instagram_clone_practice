import 'package:flutter/material.dart';
import 'package:instagram_clone_practice/firebase/firestore_methods.dart';
import 'package:instagram_clone_practice/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentsCard extends StatelessWidget {
  const CommentsCard({super.key, required this.snapshot, required this.postId});
  final snapshot;
  final String postId;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).getUser;
    print(snapshot);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              snapshot['profilePhoto'],
            ),
            radius: 18,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${snapshot['name']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '  ${snapshot['comment']}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat.yMMMEd().format(snapshot['date'].toDate()),
                )
              ],
            ),
          ),
          Expanded(child: Container()),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () async {
                  await FirestoreMethods().likeComment(
                      uid: user.uid,
                      postId: postId,
                      commentId: snapshot['commentId'],
                      likes: snapshot['likes']);
                }, // },
                icon: snapshot['likes'].contains(user.uid)
                    ? Icon(
                        Icons.favorite_rounded,
                        color: Colors.red,
                      )
                    : const Icon(Icons.favorite_border),
              ),
              Text(snapshot['likes'].length.toString())
            ],
          ),
        ],
      ),
    );
  }
}
