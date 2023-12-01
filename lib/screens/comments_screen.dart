import 'package:flutter/material.dart';
import 'package:instagram_clone_practice/providers/user_provider.dart';
import 'package:instagram_clone_practice/utilities/colors.dart';
import 'package:instagram_clone_practice/widgets/comment_card.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key});
  final TextEditingController controller = TextEditingController();

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
                  onPressed: () {},
                  child: Text(
                    'Post',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ),
      ),
      body: CommentsCard(),
    );
  }
}
