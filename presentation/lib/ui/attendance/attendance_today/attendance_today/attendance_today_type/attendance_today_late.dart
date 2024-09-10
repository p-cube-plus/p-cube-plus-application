import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/extensions/date_time_extension.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class AttendanceTodayLate extends StatelessWidget {
  final DateTime checkedTime;

  const AttendanceTodayLate(this.checkedTime, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        SvgPicture.asset(
          asset.late,
          height: 48,
          width: 48,
        ),
        const SizedBox(width: 16),
        Center(
          child: Column(
            children: [
              Text(
                "지각",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: theme.neutral40,
                ),
              ),
              Text(
                checkedTime.format("h시 m분 s초"),
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  color: theme.neutral40,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
