import 'package:flutter/material.dart';

class DragDetector extends StatelessWidget {
  final Function() moveLeftContent;
  final Function() moveRightContent;
  final Widget child;

  final double _scrollSensitivity = 20.0;

  const DragDetector({
    super.key,
    required this.moveLeftContent,
    required this.moveRightContent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    double startX = 0.0;
    double positionX = 0.0;

    return GestureDetector(
      onHorizontalDragStart: (details) => startX = details.globalPosition.dx,
      onHorizontalDragUpdate: (details) => positionX = details.localPosition.dx,
      onHorizontalDragEnd: (details) =>
          _scrollAction(context, startX, positionX),
      child: child,
    );
  }

  void _scrollAction(BuildContext context, double startX, double endX) {
    if (endX - startX > _scrollSensitivity) {
      moveLeftContent();
    } else if (startX - endX > _scrollSensitivity) {
      moveRightContent();
    }
  }
}
