import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class SkeletonAnimation extends StatefulWidget {
  final double width;
  final double height;
  final double radius;
  final Color? baseColor;
  final Color? subColor;

  const SkeletonAnimation(
    this.width,
    this.height, {
    super.key,
    this.radius = 4,
    this.baseColor,
    this.subColor,
  });

  @override
  SkeletonAnimationState createState() => SkeletonAnimationState();
}

class SkeletonAnimationState extends State<SkeletonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: -0.5, end: 1.5).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: CustomPaint(
            size: Size(widget.width, widget.height),
            painter: _SkeletonPainter(
              baseColor: widget.baseColor ?? theme.neutral10,
              subColor: widget.subColor ?? theme.neutral10.withOpacity(0.4),
              progress: _animation.value,
              subWidth: widget.width,
            ),
          ),
        );
      },
    );
  }
}

class _SkeletonPainter extends CustomPainter {
  final Color baseColor;
  final Color subColor;
  final double progress;
  final double subWidth;

  _SkeletonPainter({
    required this.baseColor,
    required this.subColor,
    required this.progress,
    required this.subWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final startX = progress * size.width;

    paint.shader = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        baseColor,
        subColor,
        baseColor,
      ],
      stops: [
        0.0,
        0.5,
        1.0,
      ],
    ).createShader(
      Rect.fromLTWH(startX - subWidth / 2, 0, subWidth, size.height),
    );

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
