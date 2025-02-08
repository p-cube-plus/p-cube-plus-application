import 'package:flutter/material.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

class ExecutiveAlarmSettingSkeleton extends StatelessWidget {
  const ExecutiveAlarmSettingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedBorder(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 16),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonAnimation(92, 14),
              SkeletonAnimation(48, 14),
            ],
          ),
        ),
        const SizedBox(height: 16),
        RoundedBorder(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 16),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonAnimation(48, 14),
              SkeletonAnimation(120, 24),
            ],
          ),
        ),
      ],
    );
  }
}
