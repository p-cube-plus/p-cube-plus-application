import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class DefaultProfile extends StatelessWidget {
  const DefaultProfile({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.neutral10,
        boxShadow: [
          BoxShadow(
            color: theme.neutral10,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Center(child: _PeopleImage(size / 5, theme.neutral20)),
    );
  }
}

class _PeopleImage extends StatelessWidget {
  final double size;
  final Color color;
  const _PeopleImage(this.size, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: size / 4),
        SemiCircle(size * 2, color),
      ],
    );
  }
}

class SemiCircle extends StatelessWidget {
  final double diameter;
  final Color color;

  const SemiCircle(this.diameter, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SemiCirclePainter(color),
      size: Size(diameter, diameter / 2),
    );
  }
}

class SemiCirclePainter extends CustomPainter {
  final Color color;
  SemiCirclePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height * 2);

    canvas.drawArc(
      rect,
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
