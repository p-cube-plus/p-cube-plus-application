import 'package:flutter/material.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

class FeeHistoryAccountTextSkeleton extends StatelessWidget {
  const FeeHistoryAccountTextSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(140, 16);
  }
}
