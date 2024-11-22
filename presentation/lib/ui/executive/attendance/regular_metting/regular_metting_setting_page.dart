import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/regular_metting/member_attendance.dart';
import 'package:presentation/ui/executive/attendance/regular_metting/regular_metting_setting_view_model.dart';
import 'package:presentation/ui/executive/attendance/restricted_date_picker/restricted_date_picker.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_bottomsheet.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:provider/provider.dart';

class RegularMettingSettingPage extends StatelessWidget {
  const RegularMettingSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegularMettingSettingViewModel(RegularMetting()),
      child: _RegularMettingSettingPage(),
    );
  }
}

class _RegularMettingSettingPage extends StatefulWidget
    with ViewModel<RegularMettingSettingViewModel> {
  @override
  State<_RegularMettingSettingPage> createState() =>
      _RegularMettingSettingPageState();
}

class _RegularMettingSettingPageState
    extends State<_RegularMettingSettingPage> {
  var _refreshKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(
        backgroundColor: theme.primary80,
        leftTitle: "정기회의 출석",
      ),
      content: DefaultFutureBuilder(
          key: _refreshKey,
          fetchData: widget.read(context).fetchAttendanceDetailData(),
          showOnLoadedWidget: (context, data) {
            return Column(
              children: [
                widget.watchWidget((viewModel) => viewModel.isVisibleTopWidget,
                    (context, isVisibleTopWidget) {
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
                            GestureDetector(
                              onTap: () => _showDatePickerBottomSheet(),
                              child: Text(
                                data.attendanceDate.format("M월 dd일"),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: theme.neutral100,
                                ),
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
                              padding:
                                  const EdgeInsets.only(left: 8, right: 20),
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
                              child: Builder(builder: (context) {
                                if (data.isExistFirstAttendance) {
                                  return RoundedBorder(
                                    color: theme.neutral10,
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        Text(
                                          data.firstAttendanceStartTime!
                                              .format("hh시 mm분 ss초 ~"),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: theme.neutral100,
                                          ),
                                        ),
                                        Text(
                                          data.firstAttendanceEndTime!
                                              .format("hh시 mm분 ss초"),
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
                                    color: theme.neutral10,
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    onTap: () =>
                                        _showAttendanceTimeSettingBottomSheet(
                                            1),
                                    child: Text(
                                      "눌러서 1차 인증 시간을 설정해주세요",
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
                        SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 20),
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
                                if (data.isExistSecondAttendance) {
                                  return RoundedBorder(
                                    color: theme.neutral5,
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        Text(
                                          data.secondAttendanceStartTime!
                                              .format("hh시 mm분 ss초 ~"),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: theme.neutral100,
                                          ),
                                        ),
                                        Text(
                                          data.secondAttendanceEndTime!
                                              .format("hh시 mm분 ss초"),
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
                                    color: theme.neutral5,
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    onTap: () =>
                                        _showAttendanceTimeSettingBottomSheet(
                                            2),
                                    child: Text(
                                      "눌러서 2차 인증 시간을 설정해주세요",
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
                  );
                }),
                Expanded(
                  child: MemberAttendanceList(
                    selectedDate: data.attendanceDate,
                    memberList: data.memberStateList,
                  ),
                ),
              ],
            );
          }),
    );
  }

  void _showAttendanceTimeSettingBottomSheet(
    int attendanceSequence,
  ) {
    BottomSheetBuilder().build(
        context,
        Container(
          height: 200,
          color: Colors.green,
        ));
  }

  void _showDatePickerBottomSheet() {
    BottomSheetBuilder().build(
      context,
      RestrictedDatePicker(
        onDateSelectionComplete: (selectedDate) {
          widget.read(context).fetchValidDateSet(selectedDate);
          setState(() => _refreshKey = UniqueKey());
        },
        onRefreshValidDates: (selectedDate) =>
            widget.read(context).fetchValidDateSet(selectedDate),
      ),
    );
  }
}
