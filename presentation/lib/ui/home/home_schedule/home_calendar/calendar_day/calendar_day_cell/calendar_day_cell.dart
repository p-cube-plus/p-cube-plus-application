import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/home/home_schedule/home_schedule_event.dart';

import '../../../home_schedule_viewmodel.dart';

class CalendarDayCell extends StatelessWidget
    with ViewModel<HomeScheduleViewmodel> {
  final int currentDay;

  const CalendarDayCell(
    this.currentDay, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: () => read(context)
            .triggerEvent(HomeScheduleEventOnClickCell(currentDay)),
        child: Center(
          child: Text(
            "$currentDay",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: theme.neutral100,
            ),
          ),
        ),
      ),
    );
  }
}
