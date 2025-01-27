import 'package:flutter/material.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

class FeeHistoryTotalTextSkeleton extends StatelessWidget {
  const FeeHistoryTotalTextSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(200, 32);
  }
}
