import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class LogoSplashWidget extends StatefulWidget {
  const LogoSplashWidget({
    super.key,
    required this.size,
  });

  final double size;

  @override
  State<LogoSplashWidget> createState() => _LogoSplashWidgetState();
}

class _LogoSplashWidgetState extends State<LogoSplashWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this)
      ..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          await Future.delayed(Duration(milliseconds: 500));
          if (!mounted) return;
          _animationController.forward(from: 0);
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Lottie.asset(
      theme.logoSplashPath,
      controller: _animationController,
      width: widget.size,
      height: widget.size,
      onLoaded: (composition) => _animationController
        ..duration = composition.duration
        ..forward(),
    );
  }
}
