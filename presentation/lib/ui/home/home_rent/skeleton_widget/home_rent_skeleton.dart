import 'package:flutter/material.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

class HomeRentSkeleton extends StatelessWidget {
  const HomeRentSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (_) {
        return RoundedBorder(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 8),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonAnimation(160, 14),
                  SizedBox(height: 4),
                  SkeletonAnimation(120, 12),
                ],
              ),
              Positioned(
                top: 8,
                right: 0,
                bottom: 8,
                child: SkeletonAnimation(60, 14),
              ),
            ],
          ),
        );
      }),
    );
  }
}
