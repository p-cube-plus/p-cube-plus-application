import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';
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

class _HomeUpcommingSchedule extends StatefulWidget {
  const _HomeUpcommingSchedule();

  @override
  State<_HomeUpcommingSchedule> createState() => _HomeUpcommingScheduleState();
}

class _HomeUpcommingScheduleState extends State<_HomeUpcommingSchedule>
    with ViewModel<HomeUpcommingScheduleViewModel> {
  var _refreshKey = UniqueKey();
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
          key: _refreshKey,
          fetchData: read(context).fetchData(),
          showOnLoadedWidget: (context, data) {
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
          showOnLoadingWidget: (context) {
            return Column(
              children: List.generate(
                2,
                (index) {
                  return RoundedBorder(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        SkeletonAnimation(72, 14),
                        SizedBox(width: 16),
                        SkeletonAnimation(170, 14),
                      ],
                    ),
                  );
                },
              ),
            );
          },
          showOnErrorWidget: (error, trace) {
            return GestureDetector(
              onTap: () => setState(() => _refreshKey = UniqueKey()),
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    "데이터 불러오기에 실패했습니다!\n터치해서 새로고침하기",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
