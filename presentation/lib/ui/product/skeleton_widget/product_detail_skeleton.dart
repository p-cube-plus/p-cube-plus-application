import 'package:flutter/material.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

class ProductDetailSkeleton extends StatelessWidget {
  const ProductDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonAnimation(40, 12),
        SizedBox(height: 8),
        RoundedBorder(
          padding: EdgeInsets.all(16),
          child: Column(
            children: List.generate(3, (index) {
              final padding = index == 2 ? 0.0 : 8.0;
              return Padding(
                padding: EdgeInsets.only(bottom: padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonAnimation(60, 14),
                    SkeletonAnimation(220, 14),
                  ],
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 36),
        SkeletonAnimation(40, 12),
        SizedBox(height: 8),
        RoundedBorder(
          padding: EdgeInsets.all(16),
          child: Column(
            children: List.generate(3, (index) {
              final padding = index == 2 ? 0.0 : 8.0;
              return Padding(
                padding: EdgeInsets.only(bottom: padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonAnimation(60, 14),
                    SkeletonAnimation(220, 14),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
