import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/alarm/executive_alarm_page.dart';
import 'package:presentation/ui/executive/attendance/executive_attendance_page.dart';
import 'package:presentation/ui/executive/setting/executive_setting_page.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class ExecutiveMainPage extends StatelessWidget {
  const ExecutiveMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(),
      content: DefaultContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "임원진",
              style: TextStyle(
                fontSize: 20,
                color: theme.neutral100,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "임원진 전용 메뉴입니다.",
              style: TextStyle(
                fontSize: 14,
                color: theme.neutral60,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: RoundedBorder(
                    onTap: () => _navigateToExecutiveAlarm(context),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Image.asset(
                          asset.executiveAlarm,
                          width: 32,
                          height: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "알림",
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.neutral100,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: RoundedBorder(
                    onTap: () => _navigateToExecutiveAttendance(context),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Image.asset(
                          asset.executiveAttendance,
                          width: 32,
                          height: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "출석",
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.neutral100,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: RoundedBorder(
                    onTap: () => _navigateToExecutiveSetting(context),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          asset.setting,
                          width: 32,
                          height: 32,
                          colorFilter: ColorFilter.mode(
                            theme.neutral60,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "설정",
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.neutral100,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToExecutiveAlarm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExecutiveAlarmPage(),
      ),
    );
  }

  void _navigateToExecutiveAttendance(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExecutiveAttendancePage(),
      ),
    );
  }

  void _navigateToExecutiveSetting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExecutiveSettingPage(),
      ),
    );
  }
}
