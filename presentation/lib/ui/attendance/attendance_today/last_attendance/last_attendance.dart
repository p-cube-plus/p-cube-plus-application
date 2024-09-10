import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/constants/asset_path.dart' as asset;
import 'last_attendance_item.dart';

class LastAttendance extends StatelessWidget {
  const LastAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          "지난 출석",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: theme.neutral80,
          ),
        ),
        const SizedBox(height: 8),
        RoundedBorder(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              return LastAttendanceItem(
                DateTime.now(),
                asset.alarmIconSelected,
              );
            }),
          ),
        ),
      ],
    );
  }
}
