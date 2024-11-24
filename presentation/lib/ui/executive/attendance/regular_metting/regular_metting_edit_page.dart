import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/attendance_schedule_box/attendance_schedule_box.dart';
import 'package:presentation/ui/executive/attendance/member_list/searchable_member_attendance.dart';
import 'package:presentation/ui/executive/attendance/attendance_edit_view_model.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:provider/provider.dart';

class RegularMettingEditPage extends StatelessWidget {
  const RegularMettingEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AttendanceEditViewModel(RegularMetting()),
      child: _RegularMettingEditPage(),
    );
  }
}

class _RegularMettingEditPage extends StatefulWidget {
  @override
  State<_RegularMettingEditPage> createState() =>
      _RegularMettingEditPageState();
}

class _RegularMettingEditPageState extends State<_RegularMettingEditPage>
    with ViewModel<AttendanceEditViewModel> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(
        backgroundColor: theme.primary80,
      ),
      title: "정기회의 출석",
      backgroundColor: theme.primary80,
      content: watchWidget(
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
                          data: data,
                          isReadOnly: false,
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
      ),
    );
  }
}
