import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/home/home_schedule/home_schedule_event.dart';
import '../../home_schedule_viewmodel.dart';

class CalendarHeader extends StatelessWidget
    with ViewModel<HomeScheduleViewmodel> {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => read(context)
                .triggerEvent(HomeScheduleEventOnClickPreviousMonth()),
            child: SizedBox(
              height: double.infinity,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Icon(
                  Icons.chevron_left,
                  color: theme.neutral40,
                  size: 24,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              watchWidget(
                (viewModel) => viewModel.selectedDate.month,
                (currentMonth) {
                  return Text(
                    "$currentMonth월",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral100,
                    ),
                  );
                },
              ),
              watchWidget(
                (viewModel) => viewModel.selectedDate.year,
                (currentYear) {
                  return Text(
                    "$currentYear년",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: theme.neutral40,
                    ),
                  );
                },
              ),
            ],
          ),
          GestureDetector(
            onTap: () =>
                read(context).triggerEvent(HomeScheduleEventOnClickNextMonth()),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Icon(
                Icons.chevron_right,
                color: theme.neutral40,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
