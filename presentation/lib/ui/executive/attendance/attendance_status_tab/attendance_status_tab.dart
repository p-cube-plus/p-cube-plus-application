import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/executive/attendance/attendance_status_tab/attendance_status_view_model.dart';
import 'package:presentation/ui/executive/attendance/attendance_schedule_box/attendance_schedule_box.dart';
import 'package:presentation/ui/executive/attendance/member_list/searchable_member_attendance.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:provider/provider.dart';

class AttendanceStatusTab extends StatelessWidget {
  final AttendanceType type;

  const AttendanceStatusTab({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AttendanceStatusViewModel(type),
      child: _AttendanceStatusTab(),
    );
  }
}

class _AttendanceStatusTab extends StatefulWidget {
  @override
  State<_AttendanceStatusTab> createState() => _AttendanceStatusTabState();
}

class _AttendanceStatusTabState extends State<_AttendanceStatusTab>
    with ViewModel<AttendanceStatusViewModel>, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return watchWidget(
      (viewModel) => viewModel.fetchAttendanceDetailData,
      (context, fetchAttendanceDetailData) {
        return DefaultFutureBuilder(
          fetchData: fetchAttendanceDetailData,
          showOnLoadedWidget: (context, data) {
            return Column(
              children: [
                watchWidget(
                  (viewModel) => viewModel.isVisibleTopWidget,
                  (context, isVisibleTopWidget) {
                    if (!isVisibleTopWidget) return SizedBox();
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      child: AttendanceScheduleBox(
                        isReadOnly: false,
                        attendanceDate: data.attendanceDate,
                        firstAttendanceStartTime: data.firstAttendanceStartTime,
                        firstAttendanceEndTime: data.firstAttendanceEndTime,
                        secondAttendanceStartTime:
                            data.secondAttendanceStartTime,
                        secondAttendanceEndTime: data.secondAttendanceEndTime,
                      ),
                    );
                  },
                ),
                Expanded(
                  child: SearchableMemberAttendance(
                    detailData: data,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
