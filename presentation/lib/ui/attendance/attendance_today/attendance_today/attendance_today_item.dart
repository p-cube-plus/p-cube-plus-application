import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/attendance/attendance_today/attendance_today_viewmodel.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class AttendanceTodayItem extends StatelessWidget
    with ViewModel<AttendanceTodayViewmodel> {
  final AttendanceData data;
  const AttendanceTodayItem(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            Text(
              "${data.attendanceCheckNumber}차 인증",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: theme.neutral40,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              data.getCheckTimeString(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: theme.primary80,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        watchWidget((viewModel) => viewModel., builder),
        Row(
          children: [
            SvgPicture.asset(
              asset.off,
              width: 48,
              height: 48,
            ),
            const SizedBox(width: 16),
            ElevatedButton(
                onPressed: onPressed,
                child: const Text(
                  "출석하기",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
      ],
    );
  }
}



class AttendanceTodayEnableAttend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class AttendanceTodayDisableAttend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}