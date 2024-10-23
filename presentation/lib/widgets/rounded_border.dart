import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class RoundedBorder extends StatelessWidget {
  const RoundedBorder({
    super.key,
    this.height,
    this.width,
    this.radius = 10.0,
    this.child,
    this.color,
    this.hasShadow = true,
    this.onTap,
    this.border,
    this.padding,
    this.margin,
  });

  final double? height;
  final double? width;
  final double radius;
  final Widget? child;
  final Color? color;
  final bool hasShadow;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Border? border;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: color ?? theme.content,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            if (hasShadow)
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 10.0,
                spreadRadius: 0.0,
                offset: Offset(0.0, 2.0),
              )
          ],
        ),
        child: child,
      ),
    );
  }
}
