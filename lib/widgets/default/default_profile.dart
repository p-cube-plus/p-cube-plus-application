import 'package:flutter/material.dart';

class DefaultProfile extends StatelessWidget {
  const DefaultProfile({
    Key? key,
    this.size,
    this.isOverflow = false,
  }) : super(key: key);

  final double? size;
  final bool isOverflow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFE9E9E9),
        image: !isOverflow
            ? DecorationImage(
                image: AssetImage('assets/images/default_profile.png'),
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            offset: Offset.fromDirection(1.0, 1.0),
            blurRadius: 3.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: isOverflow
          ? Center(
              child: Text(
              "+1",
              style: TextStyle(
                  color: Color(0xFFABABAB),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400),
            ))
          : null,
    );
  }
}
