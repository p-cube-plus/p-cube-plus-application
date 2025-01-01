import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/home/home_attendance/home_attendance_detail/home_attendance_detail_page.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';
import 'package:provider/provider.dart';

import 'home_attendance_content/home_attendance_content.dart';
import 'home_attendnace_viewmodel.dart';

class HomeAttendence extends StatelessWidget {
  const HomeAttendence({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeAttendnaceViewModel(),
      child: const _HomeAttendence(),
    );
  }
}

class _HomeAttendence extends StatefulWidget {
  const _HomeAttendence();

  @override
  State<_HomeAttendence> createState() => _HomeAttendenceState();
}

class _HomeAttendenceState extends State<_HomeAttendence>
    with ViewModel<HomeAttendnaceViewModel> {
  var _refreshKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "출석체크",
              style: TextStyle(
                color: theme.neutral100,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: () => _navigateToAttendanceDetailPage(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "자세히 보기",
                    style: TextStyle(
                      color: theme.neutral40,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: theme.neutral40,
                    size: 20.0,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        DefaultFutureBuilder(
          key: _refreshKey,
          fetchData: read(context).fetchData(),
          showOnLoadedWidget: (context, data) {
            if (data.isEmpty) {
              return Text(
                "오늘은 출석이 없습니다.",
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
                  (index) {
                    if (index == 0) {
                      return HomeAttendanceContent(data[index]);
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: HomeAttendanceContent(data[index]),
                      );
                    }
                  },
                  growable: false,
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

  _navigateToAttendanceDetailPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HomeAttendanceDetailPage(),
    ));
  }
}
