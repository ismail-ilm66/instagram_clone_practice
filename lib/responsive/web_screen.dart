import 'package:flutter/material.dart';
import 'package:instagram_clone_practice/models/user.dart' as model;
import 'package:instagram_clone_practice/providers/user_provider.dart';
import 'package:provider/provider.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  model.User? user;

  void getUserData() {
    UserProvider userProvider = Provider.of(context, listen: false);
    userProvider.refreshUser();
    user = userProvider.getUser;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(user == null ? 'Web Screen' : user!.username),
      ),
    );
  }
}
