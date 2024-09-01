import 'package:flutter/material.dart';

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
  });

  final double? height;
  final double? width;
  final double radius;
  final Widget? child;
  final Color? color;
  final bool hasShadow;
  final EdgeInsetsGeometry? padding;
  final Border? border;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(radius),
        border: border,
        boxShadow: [
          if (hasShadow)
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 10.0,
              spreadRadius: 0.0,
              offset: Offset.fromDirection(0.0, 2.0),
            )
        ],
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        onTap: onTap,
        child: Container(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
