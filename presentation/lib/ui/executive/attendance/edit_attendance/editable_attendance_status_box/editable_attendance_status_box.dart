import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/edit_attendance/edit_attendance_view_model.dart';
import 'package:presentation/ui/executive/attendance/edit_attendance/editable_attendance_status_box/editable_attendance_status_box_item.dart';

class EditableAttendanceStatusBox extends StatelessWidget
    with ViewModel<EditAttendanceViewModel> {
  const EditableAttendanceStatusBox({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            EditableAttendanceStatusBoxItem(
              targetType: AttendanceStatusType.success,
            ),
            SizedBox(height: 8),
            Text(
              "출석",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: theme.neutral100,
              ),
            ),
          ],
        ),
        Column(
          children: [
            EditableAttendanceStatusBoxItem(
              targetType: AttendanceStatusType.late,
            ),
            SizedBox(height: 8),
            Text(
              "지각",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: theme.neutral100,
              ),
            ),
          ],
        ),
        Column(
          children: [
            EditableAttendanceStatusBoxItem(
              targetType: AttendanceStatusType.failed,
            ),
            SizedBox(height: 8),
            Text(
              "불참",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: theme.neutral100,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
