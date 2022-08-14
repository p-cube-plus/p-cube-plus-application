import 'package:flutter/material.dart';

class DefaultProfile extends StatelessWidget {
  const DefaultProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFE9E9E9),
        image: DecorationImage(
          image: AssetImage('assets/images/default_profile.png'),
        ),
      ),
    );
  }
}
