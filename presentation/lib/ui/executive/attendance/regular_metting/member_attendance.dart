import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/constants/asset_path.dart' as asset;
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/regular_metting/member_attendance_list_tab.dart';
import 'package:presentation/ui/executive/attendance/regular_metting/regular_metting_setting_view_model.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_tabbar.dart';
import 'package:presentation/widgets/default_text_field.dart';
import 'package:presentation/widgets/rounded_border.dart';

class MemberAttendanceList extends StatefulWidget {
  const MemberAttendanceList({super.key});

  @override
  State<MemberAttendanceList> createState() => _MemberAttendanceListState();
}

class _MemberAttendanceListState extends State<MemberAttendanceList>
    with ViewModel<RegularMettingSettingViewModel> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => read(context).toggleTopWidgetVisible(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: watchWidget((viewModel) => viewModel.isVisibleTopWidget,
                    (isVisibleTopWidget) {
                  if (isVisibleTopWidget) {
                    return Text("▲");
                  } else {
                    return Text("▼");
                  }
                }),
              ),
            ),
            Expanded(
              child: RoundedBorder(
                radius: 50,
                color: theme.neutral10,
                child: DefaultTextField(
                  maxLength: 20,
                  inputController: controller,
                  hintText: "  회원 이름을 검색해보세요",
                ),
              ),
            ),
            SizedBox(width: 8),
            RoundedBorder(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              margin: EdgeInsets.only(right: 20),
              radius: 50,
              child: Row(
                children: [
                  SvgPicture.asset(
                    asset.filter,
                    width: 10,
                    height: 10,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "필터",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.primary80,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: DefaultFutureBuilder(
            fetchData: read(context).fetch(),
            showOnLoadedWidget:
                (BuildContext context, List<MemberAttendanceState> data) {
              return DefaultTabBar(
                padding:
                    EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 16),
                tabLabelPadding: EdgeInsets.symmetric(vertical: 11),
                tabAlignment: TabAlignment.fill,
                tabs: [
                  DefaultTab(
                    tabName: "전체",
                    page: watchWidget(
                      (viewModel) => viewModel.totalList,
                      (totalList) => MemberAttendanceTab(
                        userAttendanceList: totalList,
                      ),
                    ),
                  ),
                  DefaultTab(
                    tabName: "출석",
                    page: watchWidget(
                      (viewModel) => viewModel.successList,
                      (totalList) => MemberAttendanceTab(
                        userAttendanceList: totalList,
                      ),
                    ),
                  ),
                  DefaultTab(
                    tabName: "지각",
                    page: watchWidget(
                      (viewModel) => viewModel.lateList,
                      (totalList) => MemberAttendanceTab(
                        userAttendanceList: totalList,
                      ),
                    ),
                  ),
                  DefaultTab(
                    tabName: "불참",
                    page: watchWidget(
                      (viewModel) => viewModel.failedList,
                      (totalList) => MemberAttendanceTab(
                        userAttendanceList: totalList,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
