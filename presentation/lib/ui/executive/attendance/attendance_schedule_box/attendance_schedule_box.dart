import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/attendance_status_tab/attendance_status_view_model.dart';
import 'package:presentation/widgets/default_bottomsheet.dart';
import 'package:presentation/widgets/drag_detector.dart';
import 'package:presentation/widgets/restricted_date_picker/restricted_date_picker.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class AttendanceScheduleBox extends StatelessWidget
    with ViewModel<AttendanceStatusViewModel> {
  const AttendanceScheduleBox({
    super.key,
    required this.isReadOnly,
    required this.attendanceDate,
    required this.firstAttendanceStartTime,
    required this.firstAttendanceEndTime,
    required this.secondAttendanceStartTime,
    required this.secondAttendanceEndTime,
  });

  final DateTime attendanceDate;
  final DateTime firstAttendanceStartTime;
  final DateTime firstAttendanceEndTime;
  final DateTime? secondAttendanceStartTime;
  final DateTime? secondAttendanceEndTime;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DragDetector(
      moveLeftContent: _movePreviousValidDate(context),
      moveRightContent: _moveNextValidDate(context),
      child: RoundedBorder(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(builder: (context) {
              if (isReadOnly) {
                return Center(
                  child: Text(
                    attendanceDate.format("M월 dd일"),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral100,
                    ),
                  ),
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _movePreviousValidDate(context),
                    child: SvgPicture.asset(
                      asset.left,
                      colorFilter: ColorFilter.mode(
                        theme.neutral40,
                        BlendMode.srcIn,
                      ),
                      width: 10,
                      height: 10,
                    ),
                  ),
                  GestureDetector(
                    onTap: _showDatePickerBottomSheet(context, attendanceDate),
                    child: Text(
                      attendanceDate.format("M월 dd일"),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: theme.neutral100,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _moveNextValidDate(context),
                    child: SvgPicture.asset(
                      asset.right,
                      colorFilter: ColorFilter.mode(
                        theme.neutral40,
                        BlendMode.srcIn,
                      ),
                      width: 10,
                      height: 10,
                    ),
                  ),
                ],
              );
            }),
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
                    hasShadow: false,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          firstAttendanceStartTime.format("HH시 mm분 ss초 ~"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: theme.neutral100,
                          ),
                        ),
                        Text(
                          firstAttendanceEndTime.format("HH시 mm분 ss초"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: theme.neutral100,
                          ),
                        ),
                      ],
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
                  child: Builder(builder: (context) {
                    if (secondAttendanceStartTime != null &&
                        secondAttendanceEndTime != null) {
                      return RoundedBorder(
                        color: theme.neutral5,
                        padding: EdgeInsets.symmetric(vertical: 4),
                        hasShadow: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              secondAttendanceStartTime!
                                  .format("HH시 mm분 ss초 ~"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: theme.neutral100,
                              ),
                            ),
                            Text(
                              secondAttendanceEndTime!.format("HH시 mm분 ss초"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: theme.neutral100,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return RoundedBorder(
                        color: theme.disabled,
                        hasShadow: false,
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "2차 인증 시간이 설정되지 않았습니다.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: theme.neutral40,
                          ),
                        ),
                      );
                    }
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void Function()? _movePreviousValidDate(BuildContext context) {
    if (isReadOnly) return null;
    return () => read(context).movePreviousValidDate(attendanceDate);
  }

  void Function()? _moveNextValidDate(BuildContext context) {
    if (isReadOnly) return null;
    return () => read(context).moveNextValidDate(attendanceDate);
  }

  void Function()? _showDatePickerBottomSheet(
      BuildContext context, DateTime currentDate) {
    if (isReadOnly) return null;

    return () => BottomSheetBuilder().build(
          context,
          RestrictedDatePicker(
            targetYear: currentDate.year,
            targetMonth: currentDate.month,
            onDateSelectionComplete: (selectedDate) {
              Navigator.of(context).pop();
              read(context).changeSelectedDate(selectedDate);
            },
            fetchRefreshValidDates: (selectedDate) =>
                read(context).fetchValidDateSet(selectedDate),
          ),
        );
  }
}
