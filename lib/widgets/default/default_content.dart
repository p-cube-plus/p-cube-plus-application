import 'package:flutter/material.dart';

class DefaultContent extends StatelessWidget {
  const DefaultContent(
      {this.child,
      this.bottomPadding = 24.0,
      this.bottomButtonText,
      this.onTap});
  final Widget? child;
  final double bottomPadding;
  final String? bottomButtonText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            // GlowingOverscrollIndicator: Android
            // physics: BouncingScrollPhysics() : IOS
            physics: BouncingScrollPhysics(),
            child: Padding(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: bottomPadding),
                child: child),
          ),
        ),
        if (bottomButtonText != null)
          Positioned(
            bottom: 32.0,
            left: 20.0,
            right: 20.0,
            child: Container(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: onTap ?? () {},
                child: Text(
                  bottomButtonText!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          )
      ],
    );
  }
}
