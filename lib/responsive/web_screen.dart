import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone_practice/models/user.dart' as model;
import 'package:instagram_clone_practice/providers/user_provider.dart';
import 'package:instagram_clone_practice/responsive/feed_screen.dart';
import 'package:instagram_clone_practice/screens/add_post_screen.dart';
import 'package:instagram_clone_practice/screens/profile_screen.dart';
import 'package:instagram_clone_practice/screens/search_screen.dart';
import 'package:instagram_clone_practice/utilities/colors.dart';
import 'package:provider/provider.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  model.User? user;
  int _page = 0;
  PageController? _pageController;
  void getUserData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    user = userProvider.getUser;
    setState(() {});
  }

  void jumpToOther_page(int p) {
    _pageController!.jumpToPage(p);
    setState(() {
      _page = p;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    getUserData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          'assets\/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () => jumpToOther_page(0),
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => jumpToOther_page(1),
            icon: Icon(
              Icons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => jumpToOther_page(2),
            icon: Icon(
              Icons.add_a_photo,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => jumpToOther_page(3),
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => jumpToOther_page(4),
            icon: Icon(
              Icons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
          ),
        ],
      ),
      body: Center(
        child: PageView(
          controller: _pageController,
          onPageChanged: (value) {
            setState(() {
              _page = value;
            });
          },
          children: [
            const Feeds(),
            const SearchScreen(),
            const AddPost(),
            const Center(child: Text('Favorite')),
            // const LoginScreen(),
            ProfileScreen(uid: user!.uid),
          ],
        ),
      ),
    );
  }
}
