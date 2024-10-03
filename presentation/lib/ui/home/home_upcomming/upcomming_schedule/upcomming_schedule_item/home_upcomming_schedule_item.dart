import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/schedule/value_objects/schedule_data.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/rounded_border.dart';

class HomeUpcommingScheduleItem extends StatelessWidget {
  const HomeUpcommingScheduleItem(this.data, {super.key});

  final ScheduleData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RoundedBorder(
      height: 56,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          Container(
            height: 7.0,
            width: 7.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(data.type.color.hex),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                data.startDate.format("yyyy.MM.dd"),
                style: TextStyle(
                  fontSize: 10,
                  color: theme.neutral60,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (!data.startDate.isSameDay(data.endDate))
                Text(
                  data.endDate.format("~yyyy.MM.dd"),
                  style: TextStyle(
                    fontSize: 10,
                    color: theme.neutral60,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
          Text(
            data.title,
            style: TextStyle(
              fontSize: 12,
              color: theme.neutral100,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
