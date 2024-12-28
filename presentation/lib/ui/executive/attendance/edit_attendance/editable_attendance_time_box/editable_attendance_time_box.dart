import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/edit_attendance/edit_attendance_view_model.dart';
import 'package:presentation/ui/executive/attendance/edit_attendance/editable_attendance_time_box/attendance_time_picker.dart';
import 'package:presentation/widgets/default_bottomsheet.dart';
import 'package:presentation/widgets/rounded_border.dart';

class EditableAttendanceTimeBox extends StatelessWidget
    with ViewModel<EditAttendanceViewModel> {
  const EditableAttendanceTimeBox({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isExistSecondAttendance = read(context).isExistSecondAttendance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "출석 시간",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: theme.neutral40,
          ),
        ),
        SizedBox(height: 8),
        RoundedBorder(
          onTap: () => _showSetTimeBottomSheet(context, 1),
          radius: 40,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text(
                "1차",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: theme.neutral40,
                ),
              ),
              Expanded(
                child: Center(
                  child: watchWidget(
                      (viewModel) => viewModel.memberFirstAttendanceTime,
                      (context, time) {
                    return Text(
                      time!.format("HH시 mm분 ss초"),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: theme.neutral40,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        RoundedBorder(
          radius: 40,
          onTap: isExistSecondAttendance
              ? () => _showSetTimeBottomSheet(context, 2)
              : null,
          color: isExistSecondAttendance ? theme.content : theme.disabled,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text(
                "2차",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: theme.neutral40,
                ),
              ),
              Expanded(
                child: Center(
                  child: watchWidget(
                      (viewModel) => viewModel.memberSecondAttendanceTime,
                      (context, time) {
                    if (!isExistSecondAttendance) {
                      return Text(
                        "2차 인증이 설정되지 않았습니다.",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: theme.neutral40,
                        ),
                      );
                    }
                    return Text(
                      time!.format("HH시 mm분 ss초"),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: theme.neutral40,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSetTimeBottomSheet(
    BuildContext context,
    int sequenceNumber,
  ) {
    DateTime targetDate;
    if (sequenceNumber == 1) {
      targetDate = read(context).memberFirstAttendanceTime!;
    } else {
      targetDate = read(context).memberSecondAttendanceTime!;
    }

    BottomSheetBuilder().build(
      context,
      AttendanceTimePicker(
        sequenceNumber: sequenceNumber,
        initializeTime: targetDate,
        onSaveTime: (DateTime selectedTime) {
          read(context).changeFirstAttendanceTime(selectedTime);
        },
      ),
    );
  }
}
