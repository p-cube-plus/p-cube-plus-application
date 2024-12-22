import 'package:flutter/material.dart';

class StatusFail extends StatelessWidget {
  final double size;
  const StatusFail({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Color(0xFFDF3D3D),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x4DDF3D3D),
            offset: Offset.fromDirection(0.0, 2.0),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Icon(
        Icons.clear_rounded,
        color: Colors.white,
        size: size * 0.7,
      ),
    );
  }
}
