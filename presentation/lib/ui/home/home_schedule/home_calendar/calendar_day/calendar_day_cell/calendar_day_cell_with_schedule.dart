import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/home/home_schedule/home_schedule_event.dart';

import '../../../home_schedule_viewmodel.dart';

class CalendarDayCellWithSchedule extends StatelessWidget
    with ViewModel<HomeScheduleViewmodel> {
  final int currentDay;
  final Color scheduleColor;

  const CalendarDayCellWithSchedule(
    this.currentDay,
    this.scheduleColor, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
        onTap: () => read(context)
            .triggerEvent(HomeScheduleEventOnClickCell(currentDay)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$currentDay",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: theme.neutral100,
              ),
            ),
            const SizedBox(height: 2.0),
            Container(
              height: 4.0,
              width: 4.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: scheduleColor,
              ),
            ),
          ],
        ));
  }
}
