import 'package:flutter/material.dart';

class RoundedBorder extends StatelessWidget {
  const RoundedBorder({
    Key? key,
    this.height,
    this.width,
    required this.radius,
    this.child,
    this.color,
    this.hasShadow,
    this.onTap,
    this.padding,
  }) : super(key: key);

  final double? height;
  final double? width;
  final BorderRadius radius;
  final Widget? child;
  final Color? color;
  final bool? hasShadow;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).cardColor,
          borderRadius: radius,
          boxShadow: (hasShadow ?? true)
              ? [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                    offset: Offset.fromDirection(0, 2.0),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.white.withAlpha(0),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: radius,
            ),
            onTap: onTap,
            child: Container(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
