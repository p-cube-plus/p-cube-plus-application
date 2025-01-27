import 'package:flutter/material.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

class CurrentMonthFeeSkeleton extends StatelessWidget {
  const CurrentMonthFeeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          SkeletonAnimation(72, 72, radius: 100),
          SizedBox(height: 16),
          SkeletonAnimation(80, 16),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonAnimation(64, 14),
              SkeletonAnimation(145, 14),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonAnimation(64, 14),
              SkeletonAnimation(83, 14),
            ],
          ),
        ],
      ),
    );
  }
}
