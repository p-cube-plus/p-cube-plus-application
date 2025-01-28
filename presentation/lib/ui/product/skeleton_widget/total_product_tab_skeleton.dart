import 'package:flutter/material.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

class TotalProductTabSkeleton extends StatelessWidget {
  const TotalProductTabSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(5, (_) {
        return RoundedBorder(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonAnimation(120, 16),
              SkeletonAnimation(160, 16),
            ],
          ),
        );
      }),
    );
  }
}
