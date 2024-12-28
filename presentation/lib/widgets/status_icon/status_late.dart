import 'package:flutter/material.dart';

class StatusLate extends StatelessWidget {
  final double size;
  const StatusLate({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Color(0xFFFFAF65),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x4DFFAF65),
            offset: Offset.fromDirection(0.0, 2.0),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Icon(
        Icons.check_rounded,
        color: Colors.white,
        size: size * 0.7,
      ),
    );
  }
}