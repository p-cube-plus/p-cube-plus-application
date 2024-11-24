import 'package:domain/attendance/value_objects/attendance_detail_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/constants/asset_path.dart' as asset;
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/member_list/member_attendance_list_tab.dart';
import 'package:presentation/ui/executive/attendance/attendance_edit_view_model.dart';
import 'package:presentation/ui/executive/attendance/member_list/member_filter_bottom_sheet.dart';
import 'package:presentation/widgets/default_bottomsheet.dart';
import 'package:presentation/widgets/default_tabbar.dart';
import 'package:presentation/widgets/default_text_field.dart';
import 'package:presentation/widgets/rounded_border.dart';

class SearchableMemberAttendance extends StatefulWidget {
  const SearchableMemberAttendance({
    super.key,
    required this.detailData,
  });

  final AttendanceDetailData detailData;

  @override
  State<SearchableMemberAttendance> createState() =>
      _SearchableMemberAttendance();
}

class _SearchableMemberAttendance extends State<SearchableMemberAttendance>
    with ViewModel<AttendanceEditViewModel> {
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
    final memberList = widget.detailData.memberStateList;
    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: Container(
        color: theme.content,
        child: Column(
          children: [
            SizedBox(height: 12),
            Row(
              children: [
                GestureDetector(
                  onTap: () => read(context).toggleTopWidgetVisible(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child:
                        watchWidget((viewModel) => viewModel.isVisibleTopWidget,
                            (context, isVisibleTopWidget) {
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
                  color: theme.primary10,
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
              child: DefaultTabBar(
                padding:
                    EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 16),
                tabLabelPadding: EdgeInsets.symmetric(vertical: 11),
                tabAlignment: TabAlignment.fill,
                tabs: [
                  DefaultTab(
                    tabName: "전체",
                    page: watchWidget(
                      (viewModel) => viewModel.getTotalList(memberList),
                      (context, totalList) => MemberAttendanceTab(
                        detailData: widget.detailData,
                        userAttendanceList: totalList,
                      ),
                    ),
                  ),
                  DefaultTab(
                    tabName: "출석",
                    page: watchWidget(
                      (viewModel) => viewModel.getSuccessList(memberList),
                      (context, totalList) => MemberAttendanceTab(
                        detailData: widget.detailData,
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
                      (viewModel) => viewModel.getLateList(memberList),
                      (context, totalList) => MemberAttendanceTab(
                        detailData: widget.detailData,
                        userAttendanceList: totalList,
                      ),
                    ),
                  ),
                  DefaultTab(
                    tabName: "불참",
                    page: watchWidget(
                      (viewModel) => viewModel.getFailedList(memberList),
                      (context, totalList) => MemberAttendanceTab(
                        detailData: widget.detailData,
                        userAttendanceList: totalList,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
