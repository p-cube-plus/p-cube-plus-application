import 'package:flutter/material.dart';

class DefaultScrollView extends StatelessWidget {
  DefaultScrollView({
    this.isReverse,
    required this.child,
  });
  final bool? isReverse;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: isReverse ?? false,
      // GlowingOverscrollIndicator: Android
      // physics: BouncingScrollPhysics() : IOS
      //physics: BouncingScrollPhysics(),
      physics: AlwaysScrollableScrollPhysics(),
      child: child,
    );
  }
}
