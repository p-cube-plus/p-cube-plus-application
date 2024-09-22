import 'package:flutter/material.dart';
import 'package:presentation/extensions/date_time_extension.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class AttendanceTodayItemTimeText extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;

  const AttendanceTodayItemTimeText(this.startDate, this.endDate, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (startDate != null && endDate != null) {
      return Text(
        "${startDate!.format("hh시 mm분 ss초")} ~ ${endDate!.format("hh시 mm분 ss초")}",
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: theme.primary80,
        ),
      );
    } else {
      return Text(
        "아직 2차 인증 시간이 정해지지 않았어요.",
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: theme.primary80,
        ),
      );
    }
  }
}
