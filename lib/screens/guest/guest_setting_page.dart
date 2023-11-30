import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/view_provider/theme_provider.dart';
import 'package:p_cube_plus_application/screens/login/login_page.dart';
import 'package:p_cube_plus_application/screens/settings/setting_page.dart';
import 'package:p_cube_plus_application/widgets/common/default_bottomsheet.dart';
import 'package:p_cube_plus_application/widgets/common/default_profile.dart';
import 'package:p_cube_plus_application/widgets/common/list_divider.dart';
import 'package:p_cube_plus_application/widgets/page/default_appbar.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';
import 'package:p_cube_plus_application/widgets/setting/setting_tile.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class GuestSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    final theme = Theme.of(context);

    return DefaultPage(
      title: "설정",
      appbar: DefaultAppBar(),
      content: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Column(
            children: [
              SettingTile(
                  title: "테마 설정",
                  optionText: Text(
                    _getMode(themeProvider.type),
                    style: theme.textTheme.displaySmall!
                        .copyWith(fontSize: 12.0, fontWeight: FontWeight.w400),
                  ),
                  onTap: () => showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      builder: (context) => DefaultBottomsheet(
                            title: "테마 설정",
                            bottomPadding: 48,
                            contents: [
                              SettingRadioBox(
                                  type: ThemeMode.system, text: "시스템 설정 사용"),
                              SettingRadioBox(
                                  type: ThemeMode.light, text: "라이트 모드"),
                              SettingRadioBox(
                                  type: ThemeMode.dark, text: "다크 모드"),
                            ],
                          ))),
              ListDivider(horizontal: 20, vertial: 10.0),
              SettingTile(
                title: "버전",
                hasIcon: false,
                optionText: FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('버전 확인 실패');
                      } else if (!snapshot.hasData) {
                        return const Text('버전 확인중');
                      }
                      return Text(
                        "v" + snapshot.data!.version,
                        style: theme.textTheme.displayMedium!.copyWith(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      );
                    }),
              ),
              SettingTile(
                title: "개발진 목록",
                onTap: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    builder: (context) => DefaultBottomsheet(
                          title: "개발진 목록",
                          bottomPadding: 8,
                          contents: [
                            Container(
                              height: 630,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: ListView.builder(
                                  itemCount: 7,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  DefaultProfile(size: 32),
                                                  SizedBox(width: 16),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "오창한",
                                                        style: theme.textTheme
                                                            .headlineSmall!
                                                            .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(height: 3),
                                                      Text(
                                                        "컴퓨터공학과 18학번",
                                                        style: theme.textTheme
                                                            .headlineSmall!
                                                            .copyWith(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "프로그래밍",
                                                    style: theme.textTheme
                                                        .headlineSmall!
                                                        .copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text("졸업회원",
                                                      style: theme.textTheme
                                                          .displaySmall!
                                                          .copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        if (index < 6)
                                          ListDivider()
                                        else
                                          SizedBox(height: 8)
                                      ],
                                    );
                                  }),
                            )
                          ],
                        )),
              ),
              ListDivider(horizontal: 20),
              SettingTile(
                  title: "로그인 화면으로 돌아가기",
                  onTap: () =>
                      Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                        pageBuilder: (BuildContext context, Animation animation,
                            Animation secondaryAnimation) {
                          return LoginPage();
                        },
                      ), (Route route) => false))
            ],
          ),
        ),
      ),
    );
  }

  String _getMode(ThemeMode type) {
    return type == ThemeMode.system
        ? "시스템 설정 사용"
        : type == ThemeMode.light
            ? "라이트 모드"
            : "다크 모드";
  }
}
