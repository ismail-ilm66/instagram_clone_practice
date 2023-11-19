import 'package:flutter/material.dart';
import 'package:instagram_clone_practice/models/user.dart' as model;
import 'package:instagram_clone_practice/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
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
    getUserData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(user == null ? 'Mobile Screen' : user!.username),
      ),
    );
  }
}
