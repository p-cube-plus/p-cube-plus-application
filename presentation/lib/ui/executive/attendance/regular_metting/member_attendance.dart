import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/constants/asset_path.dart' as asset;
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/regular_metting/member_attendance_list_tab.dart';
import 'package:presentation/ui/executive/attendance/regular_metting/regular_metting_setting_view_model.dart';
import 'package:presentation/widgets/defauilt_toggle_tile.dart';
import 'package:presentation/widgets/default_bottomsheet.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_tabbar.dart';
import 'package:presentation/widgets/default_text_field.dart';
import 'package:presentation/widgets/rounded_border.dart';

class MemberAttendanceList extends StatefulWidget {
  const MemberAttendanceList({
    super.key,
    required this.selectedDate,
  });

  final DateTime selectedDate;

  @override
  State<MemberAttendanceList> createState() => _MemberAttendanceListState();
}

class _MemberAttendanceListState extends State<MemberAttendanceList>
    with ViewModel<RegularMettingSettingViewModel> {
  final controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => read(context).toggleTopWidgetVisible(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child:
                      watchWidget((viewModel) => viewModel.isVisibleTopWidget,
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
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: DefaultTextField(
                    maxLength: 20,
                    inputController: controller,
                    focusNode: _focusNode,
                    hintText: "회원 이름을 검색해보세요",
                    onChanged: (inputText) {
                      read(context).setFilterText(inputText);
                    },
                  ),
                ),
              ),
              SizedBox(width: 8),
              RoundedBorder(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                margin: EdgeInsets.only(right: 20),
                radius: 50,
                onTap: () => _showFilterBottomSheet(),
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
              fetchData:
                  read(context).fetchUserAttendanceList(widget.selectedDate),
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
                        shouldRebuild: (previous, next) {
                          return previous.length != next.length;
                        },
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
      ),
    );
  }

  void _showFilterBottomSheet() {
    BottomSheetBuilder().build(
      context,
      MemberFilterBottomSheet(),
    );
  }
}

class MemberFilterBottomSheet extends StatelessWidget {
  const MemberFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 32),
          child: Text(
            "필터",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: theme.neutral100,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "회원 분류",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: theme.neutral100,
            ),
          ),
        ),
        DefaultToggleTile(title: "활동 회원만 보기", value: true),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 24),
          child: Text(
            "정렬",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: theme.neutral100,
            ),
          ),
        ),
        RoundedBorder(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(4.0),
          width: double.infinity,
          color: Colors.transparent,
          radius: 40,
          hasBorder: true,
          child: Row(
            children: [
              Expanded(
                child: RoundedBorder(
                  radius: 40,
                  color: theme.primary10,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "이름 순",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: theme.primary80,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: RoundedBorder(
                  radius: 40,
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "회원구분 순",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: ElevatedButton(
            onPressed: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "필터 적용하기",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
