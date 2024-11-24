import 'package:domain/attendance/value_objects/attendance_detail_data.dart';
import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/attendance_schedule_box/attendance_schedule_box.dart';
import 'package:presentation/ui/executive/attendance/edit_attendance/ediable_attendance_time_box/editable_attendance_time_box.dart';
import 'package:presentation/ui/executive/attendance/edit_attendance/edit_attendance_view_model.dart';
import 'package:presentation/ui/executive/attendance/edit_attendance/editable_attendance_status_box/editable_attendance_status_box.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:provider/provider.dart';

class EditAttendancePage extends StatelessWidget {
  const EditAttendancePage({
    super.key,
    required this.attendanceSchedule,
    required this.memberAttendance,
  });

  final AttendanceDetailData attendanceSchedule;
  final MemberAttendanceState memberAttendance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditAttendanceViewModel(
        type: memberAttendance.attendanceStatusType,
        firstAttendanceTime: attendanceSchedule.firstAttendanceStartTime!,
        secondAttendanceTime: attendanceSchedule.secondAttendanceStartTime,
      ),
      child: _EditAttendancePage(
        attendanceSchedule: attendanceSchedule,
        memberAttendance: memberAttendance,
      ),
    );
  }
}

class _EditAttendancePage extends StatelessWidget {
  final AttendanceDetailData attendanceSchedule;
  final MemberAttendanceState memberAttendance;
  const _EditAttendancePage({
    required this.attendanceSchedule,
    required this.memberAttendance,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: "출석 정보 추가하기",
        bottomPadding: 0,
      ),
      bottomContent: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: ElevatedButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text("수정 사항 저장하기"),
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AttendanceScheduleBox(data: attendanceSchedule, isReadOnly: true),
              SizedBox(height: 32),
              Text(
                "회원 정보",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: theme.neutral40,
                ),
              ),
              SizedBox(height: 8),
              RoundedBorder(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          memberAttendance.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: theme.neutral80,
                          ),
                        ),
                        SizedBox(width: 4),
                        RoundedBorder(
                          radius: 40,
                          color: theme.secondary20,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "${memberAttendance.positionType}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: theme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${memberAttendance.partType}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: theme.neutral80,
                          ),
                        ),
                        Text(
                          "${memberAttendance.grade}학년",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: theme.neutral40,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 32),
              Text(
                "출석 결과",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: theme.neutral40,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                child: EditableAttendanceStatusBox(),
              ),
              SizedBox(height: 16),

              EditableAttendanceTimeBox(),
            ],
          ),
        ),
      ),
    );
  }
}
