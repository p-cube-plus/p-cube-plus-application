import 'package:domain/attendance/value_objects/attendance_detail_data.dart';
import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/member_list/member_attendance_list_item.dart';

class MemberAttendanceTab extends StatelessWidget {
  const MemberAttendanceTab({
    super.key,
    required this.userAttendanceList,
    required this.detailData,
    required this.controller,
  });

  final List<MemberAttendanceState> userAttendanceList;
  final AttendanceDetailData detailData;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 4),
          child: Text(
            "총 ${userAttendanceList.length}명",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: theme.neutral100,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: false,
            itemCount: userAttendanceList.length,
            padding: EdgeInsets.only(bottom: 56),
            separatorBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 1,
                color: theme.neutral40.withOpacity(0.5),
              );
            },
            controller: controller,
            itemBuilder: (context, index) {
              return MemberAttendanceListItem(
                data: userAttendanceList[index],
                detailData: detailData,
              );
            },
          ),
        ),
      ],
    );
  }
}
