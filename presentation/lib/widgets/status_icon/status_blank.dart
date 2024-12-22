import 'package:flutter/material.dart';
import 'dart:math';

class StatusBlank extends StatelessWidget {
  final double size;

  const StatusBlank({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final radius = size / 2;
    return CustomPaint(
      size: Size.fromRadius(radius),
      painter: _DottedCirclePainter(
        radius: radius,
        dashCount: 32,
        dashWidth: 1.5,
        color: Color(0xFFD5D5D5),
      ),
    );
  }
}

class _DottedCirclePainter extends CustomPainter {
  final double radius;
  final int dashCount;
  final double dashWidth;
  final Color color;

  _DottedCirclePainter({
    required this.radius,
    required this.dashCount,
    required this.dashWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = dashWidth
      ..style = PaintingStyle.stroke;

    final double angleStep = 2 * pi / dashCount;
    for (int i = 0; i < dashCount; i++) {
      final double startAngle = i * angleStep;
      final double endAngle = startAngle + angleStep * 0.5; // Adjust for gap

      final Offset start = Offset(
        size.width / 2 + radius * cos(startAngle),
        size.height / 2 + radius * sin(startAngle),
      );
      final Offset end = Offset(
        size.width / 2 + radius * cos(endAngle),
        size.height / 2 + radius * sin(endAngle),
      );

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
