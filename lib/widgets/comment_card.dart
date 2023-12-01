import 'package:flutter/material.dart';

class CommentsCard extends StatelessWidget {
  const CommentsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1659651110991-29957566a52e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8a2VhbnV8ZW58MHx8MHx8fDA%3D',
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
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'username',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '  The Comment is shown here!'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('12/21/2023')
              ],
            ),
          ),
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
