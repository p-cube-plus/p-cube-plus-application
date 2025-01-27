import 'package:flutter/material.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

class CurrentMonthFeeAccountSkeleton extends StatelessWidget {
  const CurrentMonthFeeAccountSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(140, 16);
  }
}
