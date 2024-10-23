import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/default_future_builder.dart';
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

class _HomeAttendence extends StatelessWidget
    with ViewModel<HomeAttendnaceViewModel> {
  const _HomeAttendence();

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
            fetchData: read(context).fetchData(),
            showOnLoadedWidget: (_, data) {
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
            }),
      ],
    );
  }

  _navigateToAttendanceDetailPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Container(),
    ));
  }
}
