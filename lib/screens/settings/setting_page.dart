import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/logout_page.dart';
import 'package:p_cube_plus_application/widgets/default/default_alert.dart';
import 'package:p_cube_plus_application/widgets/default/default_appbar.dart';
import 'package:p_cube_plus_application/widgets/default/default_bottomsheet.dart';
import 'package:p_cube_plus_application/widgets/default/default_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../widgets/default/list_divider.dart';
import '../../widgets/default/rounded_border.dart';
import '../../widgets/setting/setting_tile.dart';
import 'setting_notice_page.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
                  title: "알림 설정",
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingNoticePage(),
                        ),
                      )),
              SettingTile(
                title: "테마 설정",
                optionText: Text(
                  _getMode(themeProvider.type),
                  style: theme.textTheme.headline3!
                      .copyWith(fontSize: 11.0, fontWeight: FontWeight.w400),
                ),
                onTap: () =>
                    DefaultBottomsheet.getBottomsheet(context, "테마 설정", [
                  RadioBox(type: ThemeMode.system, text: "시스템 설정"),
                  RadioBox(type: ThemeMode.light, text: "라이트 모드"),
                  RadioBox(type: ThemeMode.dark, text: "다크 모드")
                ]),
              ),
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
                        snapshot.data!.version,
                        style: theme.textTheme.headline2!.copyWith(
                            fontSize: 12.0, fontWeight: FontWeight.w400),
                      );
                    }),
              ),
              SettingTile(
                  title: "피드백 보내기",
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => DefaultAlert(
                          title: "피드백 보내기",
                          children: [
                            SizedBox(height: 16.0),
                            _getinputField(theme, 1, "이름을 입력하세요"),
                            SizedBox(height: 8.0),
                            _getinputField(theme, 14, "내용을 입력하세요"),
                            SizedBox(height: 16.0),
                          ],
                          onTap: () {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => DefaultAlert(
                                title: "피드백이 제출되었습니다!",
                                description: "소중한 의견 감사합니다.",
                                messageType: MessageType.OK,
                              ),
                            );
                          },
                          messageType: MessageType.OKCancel))),
              SettingTile(
                title: "개발진 목록",
                onTap: () => showDialog(
                    context: context,
                    builder: (context) => DefaultAlert(
                          title: "개발진 목록",
                          messageType: MessageType.OK,
                          children: [
                            Text(
                              "PCube+의 개발진 목록입니다.",
                              style: theme.textTheme.headline2!.copyWith(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 26.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("오창한",
                                    style: theme.textTheme.headline2!.copyWith(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400)),
                                Text("오창한",
                                    style: theme.textTheme.headline2!.copyWith(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400)),
                                Text("오창한",
                                    style: theme.textTheme.headline2!.copyWith(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400)),
                                Text("오창한",
                                    style: theme.textTheme.headline2!.copyWith(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                            SizedBox(height: 44.0),
                          ],
                        )),
              ),
              ListDivider(horizontal: 20),
              SettingTile(
                  title: "로그아웃",
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => DefaultAlert(
                          title: "로그아웃",
                          messageType: MessageType.OKCancel,
                          description: "정말 로그아웃 하시겠습니까?",
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogoutPage()),
                              ))))
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

  Widget _getinputField(ThemeData theme, int line, String hintText) {
    return RoundedBorder(
      height: line * 10.0 + 20.0,
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        scrollPadding: EdgeInsets.all(8.0),
        maxLines: line,
        maxLength: line * 20,
        cursorColor: theme.textTheme.headline1!.color,
        style: theme.textTheme.headline1!
            .copyWith(fontSize: 10.0, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          counterText: "", // 글자수 제한 보이기 삭제
          hintText: hintText,
        ),
      ),
    );
  }
}

class RadioBox extends StatelessWidget {
  final ThemeMode type;
  final String text;
  RadioBox({required this.type, required this.text});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
      onTap: () => themeProvider.changeType(type),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 12.0)),
            Radio(
                activeColor: const Color(0xFFDE2B13),
                value: type,
                groupValue: themeProvider.type,
                onChanged: (value) => themeProvider.changeType(type))
          ],
        ),
      ),
    );
  }
}
