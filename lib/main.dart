import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_practice/responsive/mobile_screen.dart';
import 'package:instagram_clone_practice/responsive/responsive_layout.dart';
import 'package:instagram_clone_practice/responsive/web_screen.dart';
import 'package:instagram_clone_practice/screens/login_screen.dart';
import 'package:instagram_clone_practice/utilities/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBSXo7fzhgjmzaR-QsG9s0lJhsnIE5fANE',
        appId: "1:1061154345961:web:97aed15c0b4be554433178",
        messagingSenderId: "1061154345961",
        projectId: "instagram-clone-practice-328c2",
        storageBucket: "instagram-clone-practice-328c2.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        debugShowCheckedModeBanner: false,
        home: LoginScreen()
        // const ResponsiveLayout(
        //   MobileScreen: MobileScreen(),
        //   WebScreen: WebScreen(),
        // ),
        );
  }
}
