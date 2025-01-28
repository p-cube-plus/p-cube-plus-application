import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/home/home_attendance/home_attendance_detail/home_attendance_detail_view_model.dart';
import 'package:presentation/ui/home/home_attendance/home_attendance_detail/home_attendance_summary_box/attendance_summary_box.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_refresh_indicator.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

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

class _HomeAttendanceDetailPage extends StatefulWidget {
  const _HomeAttendanceDetailPage();

  @override
  State<_HomeAttendanceDetailPage> createState() =>
      _HomeAttendanceDetailPageState();
}

class _HomeAttendanceDetailPageState extends State<_HomeAttendanceDetailPage>
    with ViewModel<HomeAttendanceDetailViewModel> {
  var _refreshKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      key: _refreshKey,
      appbar: DefaultAppBar(),
      title: "출석 현황",
      content: DefaultRefreshIndicator(
        onRefresh: () async {
          setState(() {
            _refreshKey = UniqueKey();
          });
        },
        child: DefaultContent(
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
            showOnLoadingWidget: (context) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    2,
                    (index) {
                      return RoundedBorder(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(bottom: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  asset.left,
                                  colorFilter: ColorFilter.mode(
                                    theme.neutral40,
                                    BlendMode.srcIn,
                                  ),
                                  width: 12,
                                  height: 12,
                                ),
                                SkeletonAnimation(120, 16, radius: 50),
                                SvgPicture.asset(
                                  asset.right,
                                  colorFilter: ColorFilter.mode(
                                    theme.neutral40,
                                    BlendMode.srcIn,
                                  ),
                                  width: 12,
                                  height: 12,
                                ),
                              ],
                            ),
                            SizedBox(height: 18),
                            SkeletonAnimation(280, 74, radius: 10),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
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
        ),
      ),
    );
  }
}
