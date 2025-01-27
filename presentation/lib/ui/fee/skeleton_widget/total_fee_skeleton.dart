import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/fee/fee_history/fee_history_page.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

class TotalFeeSkeleton extends StatelessWidget {
  const TotalFeeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RoundedBorder(
      padding: EdgeInsets.only(left: 20, top: 16, right: 16, bottom: 16),
      onTap: () => _navigateToFeeHistoryPage(context),
      child: Row(
        children: [
          SkeletonAnimation(145, 16),
          Expanded(
            child: Text(
              "자세히 보기",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: theme.neutral40,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Icon(
            Icons.navigate_next_rounded,
            size: 24,
            color: theme.neutral40,
          ),
        ],
      ),
    );
  }

  void _navigateToFeeHistoryPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FeeHistoryPage(),
      ),
    );
  }
}
