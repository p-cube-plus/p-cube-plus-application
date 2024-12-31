import 'package:flutter/material.dart';
import 'package:presentation/widgets/default_profile_list.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

class SkeletonProject extends StatelessWidget {
  const SkeletonProject({super.key, this.count = 3});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(count, (index) {
      return RoundedBorder(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 8),
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonAnimation(156, 16, radius: 50),
                SizedBox(height: 20),
                SkeletonAnimation(180, 14, radius: 50),
                SizedBox(height: 6),
                SkeletonAnimation(180, 14, radius: 50),
              ],
            ),
            Expanded(
              child: DefaultProfileList(
                itemCount: 4,
                size: 24,
              ),
            )
          ],
        ),
      );
    }));
  }
}
