import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_practice/responsive/mobile_screen.dart';
import 'package:instagram_clone_practice/responsive/responsive_layout.dart';
import 'package:instagram_clone_practice/responsive/web_screen.dart';
import 'package:instagram_clone_practice/utilities/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: const ResponsiveLayout(
        MobileScreen: MobileScreen(),
        WebScreen: WebScreen(),
      ),
    );
  }
}
