import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/status_icon/status_pending.dart';

class CurrentMonthFeePendingNotMember extends StatelessWidget {
  const CurrentMonthFeePendingNotMember({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        StatusPending(size: 72),
        SizedBox(height: 16),
        Text(
          "납부 대상이 아닙니다.",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: theme.neutral40,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
