import 'package:flutter/material.dart';

class ListDivider extends StatelessWidget {
  const ListDivider({
    this.thickness,
    this.vertial = 0.0,
    this.horizontal = 0.0,
    this.color,
  });

  final double? vertial, horizontal, thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: vertial ?? 0.0, horizontal: horizontal ?? 0.0),
      child: Divider(
        thickness: thickness ?? 1.0,
        color: color ?? const Color(0xFFE9E9E9),
      ),
    );
  }
}
