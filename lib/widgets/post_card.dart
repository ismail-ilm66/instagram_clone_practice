import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_practice/firebase/firestore_methods.dart';
import 'package:instagram_clone_practice/providers/user_provider.dart';
import 'package:instagram_clone_practice/screens/comments_screen.dart';
import 'package:instagram_clone_practice/utilities/colors.dart';
import 'package:instagram_clone_practice/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int comments = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalComments();
  }

  void getTotalComments() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.snap['postId'])
        .collection('comments')
        .get();
    comments = querySnapshot.docs.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).getUser;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: mobileBackgroundColor,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    widget.snap['profilePhoto'],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      widget.snap['username'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: ListView(
                            shrinkWrap: true,
                            children: ['Delete Post']
                                .map((e) => InkWell(
                                      onTap: () async {
                                        Navigator.pop(context);
                                        await FirestoreMethods()
                                            .deletePost(widget.snap['postId']);

                                        setState(() {});
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 16),
                                          child: Text(e)),
                                    ))
                                .toList(),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              FirestoreMethods().likePost(
                uid: user.uid,
                postId: widget.snap['postId'],
                likes: widget.snap['likes'],
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      Future.delayed(Duration.zero, () {
                        setState(() {
                          isLikeAnimating = false;
                        });
                      });
                    },
                    child: const Icon(
                      Icons.favorite,
                      size: 130,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                  onPressed: () async {
                    await FirestoreMethods().likePost(
                      uid: user.uid,
                      postId: widget.snap['postId'],
                      likes: widget.snap['likes'],
                    );
                  },
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(Icons.favorite_border),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return CommentsScreen(
                      snapshot: widget.snap,
                    );
                  }));
                },
                icon: const Icon(
                  Icons.comment,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send_rounded,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_border,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('${widget.snap['likes'].length} likes'),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: widget.snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        TextSpan(text: '  ${widget.snap['description']}'),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return CommentsScreen(snapshot: widget.snap);
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'View All ${comments} Comments',
                      style:
                          const TextStyle(fontSize: 16, color: secondaryColor),
                    ),
                  ),
                ),
                Text(
                  DateFormat.yMMMd()
                      .format(widget.snap['datePublished'].toDate()),
                  style: const TextStyle(fontSize: 16, color: secondaryColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
