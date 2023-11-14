import 'package:flutter/material.dart';
import 'package:instagram_clone_practice/utilities/size.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget MobileScreen;
  final Widget WebScreen;
  const ResponsiveLayout(
      {super.key, required this.MobileScreen, required this.WebScreen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contstraints) {
      if (contstraints.maxWidth > webSize) {
        return WebScreen;
      } else {
        return MobileScreen;
      }
    });
  }
}
