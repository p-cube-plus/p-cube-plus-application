import 'package:flutter/material.dart';

class ListDivider extends StatelessWidget {
  final double? padding, thickness;
  final Color? color;

  const ListDivider({
    Key? key,
    this.thickness,
    this.padding,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding ?? 20.0),
      child: Divider(
        thickness: thickness ?? 1.0,
        color: color ?? const Color(0xFFE9E9E9),
      ),
    );
  }
}
