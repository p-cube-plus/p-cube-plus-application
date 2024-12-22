import 'package:flutter/material.dart';

class StatusPending extends StatelessWidget {
  final double size;
  const StatusPending({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Color(0xFFABABAB),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x4DABABAB),
            offset: Offset.fromDirection(0.0, 2.0),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Icon(
        Icons.remove_rounded,
        color: Colors.white,
        size: size * 0.7,
      ),
    );
  }
}
