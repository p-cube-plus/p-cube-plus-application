import 'package:flutter/material.dart';

class DefaultScrollView extends StatelessWidget {
  const DefaultScrollView({super.key, 
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
      physics: const AlwaysScrollableScrollPhysics(),
      child: child,
    );
  }
}
