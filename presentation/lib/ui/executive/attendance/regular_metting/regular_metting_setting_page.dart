import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/regular_metting/regular_metting_setting_view_model.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_tabbar.dart';
import 'package:presentation/widgets/default_text_field.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/constants/asset_path.dart' as asset;
import 'package:provider/provider.dart';

class RegularMettingSettingPage extends StatelessWidget {
  const RegularMettingSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegularMettingSettingViewModel(),
      child: _RegularMettingSettingPage(),
    );
  }
}

class _RegularMettingSettingPage extends StatelessWidget
    with ViewModel<RegularMettingSettingViewModel> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(
        backgroundColor: theme.primary80,
        leftTitle: "정기회의 출석",
      ),
      content: Column(
        children: [
          watchWidget((viewModel) => viewModel.isVisibleTopWidget,
              (isVisibleTopWidget) {
            if (!isVisibleTopWidget) return SizedBox();

            return RoundedBorder(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.chevron_left,
                        color: theme.neutral40,
                        size: 24,
                      ),
                      Text(
                        "M월 dd일",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: theme.neutral100,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: theme.neutral40,
                        size: 24,
                      ),
                    ],
                  ),
                  SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 20),
                        child: Text(
                          "1차 인증",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: theme.neutral100,
                          ),
                        ),
                      ),
                      Expanded(
                        child: RoundedBorder(
                          color: theme.neutral10,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "hh시 mm분 ss초 ~ hh시 mm분 ss초",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: theme.neutral100,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 20),
                        child: Text(
                          "2차 인증",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: theme.neutral100,
                          ),
                        ),
                      ),
                      Expanded(
                        child: RoundedBorder(
                          color: theme.neutral5,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "눌러서 2차 인증 시간을 설정해주세요",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: theme.neutral100,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
          Expanded(
            child: MemberAttendanceList(),
          ),
        ],
      ),
    );
  }
}

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
        SizedBox(height: 8),
        Expanded(
          child: DefaultTabBar(
            tabHeight: 8,
            isCenter: true,
            tabs: [
              DefaultTab(
                title: "전체",
                page: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, bottom: 4),
                        child: Text(
                          "총 N명",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: theme.neutral100,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: false,
                            itemCount: 20,
                            padding: EdgeInsets.all(0),
                            separatorBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                height: 1,
                                color: theme.neutral40.withOpacity(0.5),
                              );
                            },
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 22,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "김테스트",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: theme.neutral80,
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            RoundedBorder(
                                              radius: 40,
                                              color: theme.secondary20,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Text(
                                                "정회원",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  color: theme.secondary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          "n학년 · 파트명",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: theme.neutral40,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "n차",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  color: theme.neutral40,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                "hh시 mm분 ss초",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  color: theme.secondary,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "n차",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  color: theme.neutral40,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                "hh시 mm분 ss초",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  color: theme.secondary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    SvgPicture.asset(
                                      asset.success,
                                      width: 56,
                                      height: 56,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ]),
              ),
              DefaultTab(
                  title: "출석",
                  page: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 48,
                          width: double.infinity,
                          margin: EdgeInsets.all(10),
                          color: Colors.green,
                        );
                      })),
              DefaultTab(
                  title: "지각",
                  page: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 48,
                          width: double.infinity,
                          margin: EdgeInsets.all(10),
                          color: Colors.yellow,
                        );
                      })),
              DefaultTab(
                  title: "불참",
                  page: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 48,
                          width: double.infinity,
                          margin: EdgeInsets.all(10),
                          color: Colors.red,
                        );
                      })),
            ],
          ),
        ),
      ],
    );
  }
}
