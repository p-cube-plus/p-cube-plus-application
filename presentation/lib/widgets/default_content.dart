import 'package:flutter/material.dart';

import 'default_scroll_view.dart';

class DefaultContent extends StatelessWidget {
  const DefaultContent(
      {super.key,
      this.child,
      this.bottomPadding = 24.0,
      this.bottomButtonText,
      this.bottomWidget,
      this.isReverse = false,
      this.onTap,
      this.refreshFunction});
  final Widget? child;
  final bool isReverse;
  final double bottomPadding;
  final String? bottomButtonText;
  final Widget? bottomWidget;
  final Future? refreshFunction;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (bottomWidget != null) {
      children.add(Padding(
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, bottom: bottomPadding),
          child: child));
      children.add(Expanded(child: bottomWidget!));
    } else {
      children.add(Expanded(
        child: DefaultScrollView(
          isReverse: isReverse,
          child: Padding(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: bottomPadding),
              child: child),
        ),
      ));
    }
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: children,
              ),
            ),
          ],
        ),
        if (bottomButtonText != null)
          Positioned(
            bottom: 32.0,
            left: 20.0,
            right: 20.0,
            child: SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: onTap ?? () {},
                child: Text(
                  bottomButtonText!,
                  style: const TextStyle(
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
