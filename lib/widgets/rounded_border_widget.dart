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
  }) : super(key: key);

  final double? height;
  final double? width;
  final double radius;
  final Widget? child;
  final Color? color;
  final bool? hasShadow;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: color ??
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: (hasShadow ?? true)
              ? [
                  BoxShadow(
                    color: Color(0x05000000),
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
              borderRadius: BorderRadius.circular(radius),
            ),
            onTap: onTap,
            child: child,
          ),
        ),
      ),
    );
  }
}
