import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_practice/models/user.dart' as model;
import 'package:instagram_clone_practice/providers/user_provider.dart';
import 'package:instagram_clone_practice/screens/add_post_screen.dart';
import 'package:instagram_clone_practice/screens/login_screen.dart';
import 'package:instagram_clone_practice/utilities/colors.dart';
import 'package:provider/provider.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
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

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,
                color: _page == 1 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_rounded,
                color: _page == 2 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_sharp,
                color: _page == 3 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _page == 4 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: jumpToOther_page,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _page = value;
          });
        },
        children: const [
          Center(child: const Text('Home')),
          Center(child: const Text('Search')),
          AddPost(),
          Center(child: const Text('Favorite')),
          Center(child: const Text('Profile')),
        ],
      ),
    );
  }
}
