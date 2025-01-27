import 'package:flutter/material.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

class MonthFeeStatusPerYearSkeleton extends StatelessWidget {
  const MonthFeeStatusPerYearSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(280, 130);
  }
}
