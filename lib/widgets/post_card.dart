import 'package:flutter/material.dart';
import 'package:instagram_clone_practice/utilities/colors.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
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
                    'https://plus.unsplash.com/premium_photo-1682724602143-a77d75d273b1?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'username',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                                      onTap: () {},
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
                  icon: Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.35,
            width: double.infinity,
            child: Image.network(
                fit: BoxFit.cover,
                'https://plus.unsplash.com/premium_photo-1682724602143-a77d75d273b1?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1,234 Likes'),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: 'username',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        TextSpan(
                            text:
                                '  Hello There!! Verily Allah is the Greatest And The Most Merciful!!s'),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'View All 1449 Comments',
                      style: TextStyle(fontSize: 16, color: secondaryColor),
                    ),
                  ),
                ),
                Text(
                  '21/07/2023',
                  style: TextStyle(fontSize: 16, color: secondaryColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
