import 'package:domain/attendance/value_objects/attendance_detail_data.dart';
import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/edit_attendance/edit_attendance_page.dart';
import 'package:presentation/widgets/attendance_status_image.dart';
import 'package:presentation/widgets/rounded_border.dart';

class MemberAttendanceListItem extends StatelessWidget {
  const MemberAttendanceListItem({
    super.key,
    required this.data,
    required this.detailData,
  });

  final MemberAttendanceState data;
  final AttendanceDetailData detailData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.content,
      child: InkWell(
        onTap: () => _navigateToEditAttendancePage(context, detailData, data),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        data.name,
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
                        hasShadow: false,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "${data.memberType}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: theme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    "${data.grade}학년 · ${data.partType}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral40,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "1차",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: theme.neutral40,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          data.firstAttendanceCheckTime
                                  ?.format("HH시 mm분 ss초") ??
                              "-",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: theme.secondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "2차",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: theme.neutral40,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          data.secondAttendanceCheckTime
                                  ?.format("HH시 mm분 ss초") ??
                              "-",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: theme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              AttendanceStatusImage(
                data.attendanceStatusType,
                width: 56,
                height: 56,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToEditAttendancePage(
    BuildContext context,
    AttendanceDetailData attendanceSchedule,
    MemberAttendanceState memberAttendance,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditAttendancePage(
          attendanceSchedule: attendanceSchedule,
          memberAttendance: memberAttendance,
        ),
      ),
    );
  }
}
