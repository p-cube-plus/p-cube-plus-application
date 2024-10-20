import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:provider/provider.dart';

import 'home_upcomming_schedule_viewmodel.dart';
import 'upcomming_schedule/upcomming_schedule_item/home_upcomming_schedule_item.dart';

class HomeUpcommingSchedule extends StatelessWidget {
  const HomeUpcommingSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeUpcommingScheduleViewModel(),
      child: const _HomeUpcommingSchedule(),
    );
  }
}

class _HomeUpcommingSchedule extends StatelessWidget
    with ViewModel<HomeUpcommingScheduleViewModel> {
  const _HomeUpcommingSchedule();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "다가오는 일정",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: theme.neutral100,
          ),
        ),
        const SizedBox(height: 16),
        DefaultFutureBuilder(
          fetchData: read(context).fetchData(),
          showOnLoadedWidget: (data) {
            if (data.isEmpty) {
              return Text(
                "다가오는 일정이 없습니다.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: theme.neutral60,
                ),
              );
            } else {
              return Column(
                children: List.generate(
                  data.length,
                  growable: false,
                  (index) {
                    if (index == 0) {
                      return HomeUpcommingScheduleItem(
                        data[index],
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: HomeUpcommingScheduleItem(
                          data[index],
                        ),
                      );
                    }
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
