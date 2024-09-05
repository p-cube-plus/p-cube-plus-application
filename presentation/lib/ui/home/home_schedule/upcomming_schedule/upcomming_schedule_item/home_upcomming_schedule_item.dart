import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/rounded_border.dart';

import 'home_upcomming_schedule_data.dart';

class HomeUpcommingScheduleItem extends StatelessWidget {
  const HomeUpcommingScheduleItem(this.data, {super.key});

  final HomeUpcommingScheduleData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RoundedBorder(
      padding: const EdgeInsets.only(top: 8),
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
              color: data.scheduleColor,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                data.startDateString,
                style: TextStyle(
                  fontSize: 10,
                  color: theme.neutral60,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (data.endDateString != null)
                Text(
                  "~${data.endDateString}",
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
