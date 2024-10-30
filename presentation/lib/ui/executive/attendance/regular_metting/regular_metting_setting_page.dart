import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/regular_metting/member_attendance.dart';
import 'package:presentation/ui/executive/attendance/regular_metting/regular_metting_setting_view_model.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:provider/provider.dart';

class RegularMettingSettingPage extends StatelessWidget {
  const RegularMettingSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegularMettingSettingViewModel(),
      child: _RegularMettingSettingPage(),
    );
  }
}

class _RegularMettingSettingPage extends StatelessWidget
    with ViewModel<RegularMettingSettingViewModel> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(
        backgroundColor: theme.primary80,
        leftTitle: "정기회의 출석",
      ),
      content: Column(
        children: [
          watchWidget((viewModel) => viewModel.isVisibleTopWidget,
              (isVisibleTopWidget) {
            if (!isVisibleTopWidget) return SizedBox();

            return RoundedBorder(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.chevron_left,
                        color: theme.neutral40,
                        size: 24,
                      ),
                      Text(
                        "M월 dd일",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: theme.neutral100,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: theme.neutral40,
                        size: 24,
                      ),
                    ],
                  ),
                  SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 20),
                        child: Text(
                          "1차 인증",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: theme.neutral100,
                          ),
                        ),
                      ),
                      Expanded(
                        child: RoundedBorder(
                          color: theme.neutral10,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "hh시 mm분 ss초 ~ hh시 mm분 ss초",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: theme.neutral100,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 20),
                        child: Text(
                          "2차 인증",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: theme.neutral100,
                          ),
                        ),
                      ),
                      Expanded(
                        child: RoundedBorder(
                          color: theme.neutral5,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "눌러서 2차 인증 시간을 설정해주세요",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: theme.neutral100,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
          Expanded(
            child: MemberAttendanceList(),
          ),
        ],
      ),
    );
  }
}
