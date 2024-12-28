import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/attendance_status_tab/attendance_status_tab.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_tabbar.dart';
import 'package:presentation/constants/app_color.dart' as color;

class PartMettingEditPage extends StatelessWidget {
  const PartMettingEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(
        backgroundColor: theme.primary80,
        centerTitle: "파트회의 출석",
        contentColor: Colors.white,
      ),
      bottomPadding: 0,
      backgroundColor: theme.primary80,
      content: DefaultTabBar(
        tabAlignment: TabAlignment.fill,
        tabLabelPadding: EdgeInsets.all(12),
        padding: EdgeInsets.symmetric(horizontal: 20),
        background: theme.primary80,
        unselectedLabelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: color.lightGray5,
        ),
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: color.lightGray5,
        ),
        indicatorColor: color.lightGray5,
        tabs: [
          DefaultTab(
            tabName: "디자인",
            page: AttendanceStatusTab(
              type: PartMettingAttendance(MemberPartType.design),
            ),
          ),
          DefaultTab(
            tabName: "아트",
            page: AttendanceStatusTab(
              type: PartMettingAttendance(MemberPartType.art),
            ),
          ),
          DefaultTab(
            tabName: "프로그래밍",
            page: AttendanceStatusTab(
              type: PartMettingAttendance(MemberPartType.development),
            ),
          ),
        ],
      ),
    );
  }
}
