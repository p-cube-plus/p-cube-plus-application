import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/home/home_attendance/home_attendance_detail/home_attendance_summary_box/home_attendance_summary_box_view_model.dart';
import 'package:presentation/widgets/attendance_status_image.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/drag_detector.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class AttendanceSummaryBox extends StatelessWidget {
  const AttendanceSummaryBox({
    super.key,
    required this.type,
  });

  final AttendanceType type;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeAttendanceSummaryBoxViewModel(
        type: type,
      ),
      child: _AttendanceSummaryBox(),
    );
  }
}

class _AttendanceSummaryBox extends StatefulWidget
    with ViewModel<HomeAttendanceSummaryBoxViewModel> {
  _AttendanceSummaryBox();

  @override
  State<_AttendanceSummaryBox> createState() => _AttendanceSummaryBoxState();
}

class _AttendanceSummaryBoxState extends State<_AttendanceSummaryBox> {
  var _refreshKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final type = widget.read(context).type;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$type 출석 현황",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: theme.neutral100,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "지난 $type 출석 현황을 확인할 수 있어요.",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: theme.neutral40,
          ),
        ),
        SizedBox(height: 12),
        DragDetector(
          moveLeftContent: () {
            widget.read(context).movePreviousMonth();
            setState(() => _refreshKey = UniqueKey());
          },
          moveRightContent: () {
            widget.read(context).moveNextMonth();
            setState(() => _refreshKey = UniqueKey());
          },
          child: RoundedBorder(
            padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          widget.read(context).movePreviousMonth();
                          setState(() => _refreshKey = UniqueKey());
                        },
                        child: SvgPicture.asset(
                          asset.left,
                          colorFilter: ColorFilter.mode(
                            theme.neutral40,
                            BlendMode.srcIn,
                          ),
                          width: 12,
                          height: 12,
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                    ),
                    widget
                        .watchWidget((viewModel) => viewModel.selectedDateTime,
                            (context, dateTime) {
                      return Text(
                        dateTime.format("yyyy년 MM월"),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: theme.neutral100,
                        ),
                      );
                    }),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          widget.read(context).moveNextMonth();
                          setState(() => _refreshKey = UniqueKey());
                        },
                        child: SvgPicture.asset(
                          asset.right,
                          colorFilter: ColorFilter.mode(
                            theme.neutral40,
                            BlendMode.srcIn,
                          ),
                          width: 12,
                          height: 12,
                          alignment: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                DefaultFutureBuilder(
                  key: _refreshKey,
                  fetchData: widget.read(context).fetchAttendanceSummaryList(),
                  showOnLoadedWidget: (context, data) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(data.maxWeekNumber, (index) {
                        return Column(
                          children: [
                            Text(
                              "${index + 1}주차",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: theme.neutral40,
                              ),
                            ),
                            SizedBox(height: 3),
                            AttendanceStatusImage(
                              data.statusList[index],
                              width: 64,
                              height: 64,
                            ),
                          ],
                        );
                      }),
                    );
                  },
                  showOnLoadingWidget: (context) {
                    return SkeletonAnimation(280, 74, radius: 10);
                  },
                  showOnErrorWidget: (error, trace) {
                    return GestureDetector(
                      onTap: () => setState(() => _refreshKey = UniqueKey()),
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            "데이터 불러오기에 실패했습니다!\n터치해서 새로고침하기",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 48),
      ],
    );
  }
}
