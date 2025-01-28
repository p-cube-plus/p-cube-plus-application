import 'package:domain/attendance/value_objects/attendance_detail_data.dart';
import 'package:domain/member/value_objects/member_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/constants/asset_path.dart' as asset;
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/member_list/member_attendance_list_tab.dart';
import 'package:presentation/ui/executive/attendance/attendance_status_tab/attendance_status_view_model.dart';
import 'package:presentation/ui/executive/attendance/member_list/member_filter_bottom_sheet/member_filter_bottom_sheet.dart';
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
    with ViewModel<AttendanceStatusViewModel> {
  final controller = TextEditingController();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _focusNode.unfocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final memberList = widget.detailData.memberStateList;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _focusNode.unfocus(),
      child: Container(
        color: theme.content,
        child: Column(
          children: [
            SizedBox(height: 12),
            Row(
              children: [
                GestureDetector(
                  onTapDown: (details) => _focusNode.unfocus(),
                  onTap: () => read(context).toggleTopWidgetVisible(),
                  child: Container(
                    padding: EdgeInsets.only(left: 16, right: 8),
                    child:
                        watchWidget((viewModel) => viewModel.isVisibleTopWidget,
                            (context, isVisibleTopWidget) {
                      if (isVisibleTopWidget) {
                        return Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: theme.neutral10,
                            shape: BoxShape.circle,
                          ),
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..scale(1.0, -1.0),
                            child: SvgPicture.asset(
                              asset.down,
                              width: 12,
                              height: 12,
                              colorFilter: ColorFilter.mode(
                                theme.neutral40,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: theme.neutral10,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            asset.down,
                            width: 12,
                            height: 12,
                            colorFilter: ColorFilter.mode(
                              theme.neutral40,
                              BlendMode.srcIn,
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                ),
                Expanded(
                  child: RoundedBorder(
                    radius: 50,
                    color: theme.neutral10,
                    hasShadow: false,
                    padding: EdgeInsets.only(left: 4, right: 12),
                    child: Row(
                      children: [
                        Expanded(
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
                        SvgPicture.asset(
                          asset.search,
                          width: 12,
                          height: 12,
                          colorFilter: ColorFilter.mode(
                            theme.neutral40,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                RoundedBorder(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  margin: EdgeInsets.only(right: 20),
                  color: theme.primary10,
                  hasShadow: false,
                  radius: 50,
                  onTap: () => _showFilterBottomSheet(),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        asset.filter,
                        width: 10,
                        height: 10,
                        colorFilter: ColorFilter.mode(
                          theme.primary80,
                          BlendMode.srcIn,
                        ),
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
                        controller: _scrollController,
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
                        controller: _scrollController,
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
                        controller: _scrollController,
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
                        controller: _scrollController,
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
    _focusNode.unfocus();
    BottomSheetBuilder().build(
      context,
      MemberFilterBottomSheet(
        onSetFilter: (MemberFilter filter) {
          read(context).setMemberFilter(filter);
        },
      ),
    );
  }
}
