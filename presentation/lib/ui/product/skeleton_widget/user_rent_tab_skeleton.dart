import 'package:flutter/material.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

class UserRentTabSkeleton extends StatelessWidget {
  const UserRentTabSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (_) {
        return RoundedBorder(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonAnimation(120, 14),
                  SizedBox(height: 4),
                  SkeletonAnimation(64, 10),
                ],
              ),
              SkeletonAnimation(60, 16),
            ],
          ),
        );
      }),
    );
  }
}
