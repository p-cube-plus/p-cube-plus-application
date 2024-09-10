import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class LastAttendanceItem extends StatelessWidget {
  final DateTime date;
  final String assetPath;
  const LastAttendanceItem(this.date, this.assetPath, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          "${date.month}",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: theme.neutral40,
          ),
        ),
        const SizedBox(height: 8),
        SvgPicture.asset(
          assetPath,
          width: 48,
          height: 48,
        ),
      ],
    );
  }
}
