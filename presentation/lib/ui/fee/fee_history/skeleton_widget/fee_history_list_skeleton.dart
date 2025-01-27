import 'package:flutter/material.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

class FeeHistoryListSkeleton extends StatelessWidget {
  const FeeHistoryListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(3, (index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonAnimation(56, 14),
            SizedBox(height: 4),
            RoundedBorder(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  SkeletonAnimation(32, 32, radius: 100),
                  SizedBox(width: 16),
                  Expanded(child: SkeletonAnimation(80, 16)),
                  SizedBox(width: 24),
                  SkeletonAnimation(96, 16),
                ],
              ),
            ),
            SizedBox(height: 32),
          ],
        );
      }),
    );
  }
}
