import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentsCard extends StatelessWidget {
  const CommentsCard({super.key, required this.snapshot});
  final snapshot;

  @override
  Widget build(BuildContext context) {
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
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_rounded,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
