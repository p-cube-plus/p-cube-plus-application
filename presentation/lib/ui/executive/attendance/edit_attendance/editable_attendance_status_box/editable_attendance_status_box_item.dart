import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/executive/attendance/edit_attendance/edit_attendance_view_model.dart';
import 'package:presentation/widgets/attendance_status_image.dart';

class EditableAttendanceStatusBoxItem extends StatelessWidget
    with ViewModel<EditAttendanceViewModel> {
  final AttendanceStatusType targetType;

  const EditableAttendanceStatusBoxItem({super.key, required this.targetType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => read(context).changeStatusType(targetType),
      child: watchWidget(
        (viewModel) => viewModel.type,
        (context, type) {
          if (type == targetType) {
            return AttendanceStatusImage(
              targetType,
            );
          }
          return AttendanceStatusImage(
            AttendanceStatusType.blank,
          );
        },
      ),
    );
  }
}
