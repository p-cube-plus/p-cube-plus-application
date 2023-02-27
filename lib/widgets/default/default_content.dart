import 'package:flutter/material.dart';

class DefaultContent extends StatelessWidget {
  const DefaultContent({this.child, this.bottomPadding = 24.0});
  final Widget? child;
  final double bottomPadding;

// GlowingOverscrollIndicator: Android
// physics: BouncingScrollPhysics() : IOS

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, bottom: bottomPadding),
          child: child),
    );
  }
}