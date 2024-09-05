import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

import 'home_attendance_content/home_attendance_content.dart';
import 'home_attendnace_viewmodel.dart';

class HomeAttendence extends StatelessWidget
    with ViewModel<HomeAttendnaceViewModel> {
  const HomeAttendence({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
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
        watchWidget(
          (viewModel) => viewModel.contentDataList,
          (contentDataList) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return HomeAttendanceContent(contentDataList[index]);
              },
            );
          },
        ),
      ],
    );
  }

  _navigateToAttendanceDetailPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Container(),
    ));
  }
}
