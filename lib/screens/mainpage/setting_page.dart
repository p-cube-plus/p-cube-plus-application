import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/default_page_widget.dart';
import 'package:p_cube_plus_application/widgets/rounded_border_widget.dart';
import 'package:p_cube_plus_application/widgets/setting/bottomsheet_tile.dart';
import 'package:p_cube_plus_application/widgets/setting/new_page_tile.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../widgets/setting/alert_frame.dart';
import '../../widgets/list_divider_widget.dart';
import '../../widgets/setting/alert_tile.dart';
import '../../widgets/setting/version_tile.dart';
import '../logout_page.dart';
import 'setting_notice_page.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return DefaultPage(
      appBarTitle: "설정",
      appBarHasPrevious: true,
      padding: 0.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NewPageTile(title: '알림 설정', newPage: SettingNoticePage()),
          BottomSheetTile(
            title: '테마 설정',
            bottomTitle: '테마 설정',
            bottomWidgets: [
              RadioBox(
                  themeProvider: themeProvider,
                  type: ThemeMode.system,
                  text: "시스템 설정 사용"),
              RadioBox(
                  themeProvider: themeProvider,
                  type: ThemeMode.light,
                  text: "라이트 모드"),
              RadioBox(
                  themeProvider: themeProvider,
                  type: ThemeMode.dark,
                  text: "다크 모드")
            ],
          ),
          ListDivider(padding: 20),
          VersionTile(title: '버전'),
          AlertTile(
              title: '피드백 보내기',
              hasIcon: true,
              alertWidget: _getFeedback(context)),
          AlertTile(
              title: '개발진 목록', hasIcon: true, alertWidget: _getDev(context)),
          ListDivider(padding: 20),
          AlertTile(
              title: '로그아웃', hasIcon: false, alertWidget: _getLogout(context)),
        ],
      ),
    );
  }

  _getFeedback(context) {
    return AlertFrame(
      messageType: MessageType.OKCancel,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 16, bottom: 8),
          child: Text(
            '피드백 보내기',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RoundedBorder(
            radius: 4,
            child: SizedBox(
              height: 30,
              child: TextField(
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                textAlign: TextAlign.start,
                cursorColor: Theme.of(context).textTheme.headline1!.color,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: '이름을 입력하세요',
                  labelStyle: Theme.of(context).textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.none)),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: RoundedBorder(
            radius: 4,
            child: SizedBox(
              height: 160,
              child: TextField(
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                maxLines: 100,
                cursorColor: Theme.of(context).textTheme.headline1!.color,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  alignLabelWithHint: true,
                  labelText: '내용을 입력하세요',
                  labelStyle: Theme.of(context).textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.none)),
                ),
              ),
            ),
          ),
        ),
      ],
      okWidget: _getOKFeedback(context),
    );
  }

  _getOKFeedback(context) {
    return AlertFrame(messageType: MessageType.OK, children: [
      Align(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Text('피드백이 제출되었습니다!',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('소중한 의견 감사합니다.',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        )),
              ),
            ],
          ),
        ),
        alignment: Alignment.center,
      ),
    ]);
  }

  _getDev(context) {
    return AlertFrame(
      messageType: MessageType.OK,
      children: [
        Column(
          children: [
            Align(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 8),
                child: Text(
                  '개발진 목록',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  'PCube+의 개발진 목록입니다.',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 22.0, bottom: 26),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '오창한',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              Text(
                '권오민',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              Text(
                '조승빈',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              Text(
                '신혜민',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _getLogout(context) {
    return AlertFrame(
      messageType: MessageType.OKCancel,
      children: [
        Align(
          child: Padding(
            padding: const EdgeInsets.only(top: 28, bottom: 24),
            child: Column(
              children: [
                Text(
                  '로그아웃',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(height: 8),
                Text(
                  '정말 로그아웃 하시겠습니까?',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
          alignment: Alignment.center,
        ),
      ],
      okWidget: LogoutPage(),
    );
  }
}

class RadioBox extends StatelessWidget {
  final ThemeProvider themeProvider;
  final ThemeMode type;
  final String text;
  RadioBox(
      {required this.themeProvider, required this.type, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontWeight: FontWeight.w400, fontSize: 12)),
          Radio(
              activeColor: const Color(0xFFDE2B13),
              value: type,
              groupValue: themeProvider.type,
              onChanged: (value) => themeProvider.changeType(type))
        ],
      ),
    );
  }
}
