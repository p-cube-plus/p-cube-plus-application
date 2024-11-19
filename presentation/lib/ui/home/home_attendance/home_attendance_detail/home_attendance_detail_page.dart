import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/home/home_attendance/home_attendance_detail/home_attendance_detail_view_model.dart';
import 'package:presentation/ui/home/home_attendance/home_attendance_detail/home_attendance_summary_box/attendance_summary_box.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:provider/provider.dart';

class HomeAttendanceDetailPage extends StatelessWidget {
  const HomeAttendanceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeAttendanceDetailViewModel(),
      child: _HomeAttendanceDetailPage(),
    );
  }
}

class _HomeAttendanceDetailPage extends StatelessWidget
    with ViewModel<HomeAttendanceDetailViewModel> {
  const _HomeAttendanceDetailPage();

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(),
      title: "출석 현황",
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DefaultFutureBuilder(
            fetchData: read(context).fetchMemberAvailableAttendanceType(),
            showOnLoadedWidget:
                (BuildContext context, List<AttendanceType> data) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    data.length,
                    (index) {
                      return AttendanceSummaryBox(type: data[index]);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
