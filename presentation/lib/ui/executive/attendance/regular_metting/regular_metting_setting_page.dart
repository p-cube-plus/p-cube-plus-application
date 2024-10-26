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
              color: Colors.blue,
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: double.infinity,
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Icon(
                            Icons.chevron_left,
                            color: theme.neutral40,
                            size: 24,
                          ),
                        ),
                      ),
                      Text(
                        "M월 dd일",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: theme.neutral100,
                        ),
                      ),
                      SizedBox(
                        height: double.infinity,
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Icon(
                            Icons.chevron_right,
                            color: theme.neutral40,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "1차 인증",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: theme.neutral100,
                          ),
                        ),
                        RoundedBorder(
                          color: theme.neutral5,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "hh시 mm분 ss초 ~ hh시 mm분 ss초",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: theme.neutral100,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "2차 인증",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: theme.neutral100,
                          ),
                        ),
                        RoundedBorder(
                          color: theme.neutral5,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "hh시 mm분 ss초 ~ hh시 mm분 ss초",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: theme.neutral100,
                            ),
                          ),
                        ),
                      ],
                    ),
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
            TextButton(
              onPressed: () => read(context).toggleTopWidgetVisible(),
              child: Text("▲"),
            ),
            Expanded(
              child: DefaultTextField(
                maxLength: 20,
                inputController: controller,
                hintText: "회원 이름을 검색해보세요",
              ),
            ),
            SizedBox(width: 8),
            RoundedBorder(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
            SizedBox(height: 16),
          ],
        ),
        Expanded(
          child: DefaultTabBar(
            tabHeight: 11,
            isCenter: true,
            tabs: [
              DefaultTab(
                  title: "전체",
                  page: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 48,
                          width: double.infinity,
                          margin: EdgeInsets.all(10),
                          color: Colors.white,
                        );
                      })),
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
