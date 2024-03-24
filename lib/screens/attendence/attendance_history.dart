import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/services/attendance_api.dart';
import 'package:p_cube_plus_application/widgets/common/default_futureBuilder.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';

class AttendanceHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultFutureBuilder(
        fetchData: AttendanceCheckApi(1).get(),
        showFunction: (data) => DefaultPage());
  }
}
