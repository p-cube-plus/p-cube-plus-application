import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/setting_provider.dart';
import 'package:p_cube_plus_application/widgets/default_page_widget.dart';
import 'package:p_cube_plus_application/widgets/setting/new_page_tile.dart';
import 'package:p_cube_plus_application/widgets/setting/switch_tile.dart';

import '../../widgets/setting/alert_frame.dart';
import '../../widgets/list_divider_widget.dart';
import '../../widgets/setting/alert_tile.dart';
import '../../widgets/setting/version_tile.dart';
import '../logout_page.dart';
import 'setting_notice_page.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appBarTitle: "설정",
      appBarHasPrevious: true,
      padding: 0.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NewPageTile(title: '알림 설정', newPage: SettingNoticePage()),
          SwitchTile(title: '다크 모드', type: SettingType.Theme),
          ListDivider(),
          VersionTile(title: '버전'),
          AlertTile(
              title: '피드백 보내기',
              hasIcon: true,
              alertWidget: _getFeedback(context)),
          AlertTile(
              title: '개발진 목록', hasIcon: true, alertWidget: _getDev(context)),
          ListDivider(),
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
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              labelText: '이름을 입력하세요',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
            maxLines: 8,
            maxLength: 500,
            decoration: InputDecoration(
              labelText: '내용을 입력하세요',
              border: OutlineInputBorder(),
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
                    style: Theme.of(context).textTheme.headline1),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('소중한 의견 감사합니다.',
                    style: Theme.of(context).textTheme.headline2),
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
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).backgroundColor),
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'PCube+의 개발진 목록입니다.',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).backgroundColor),
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 26),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('오창한', style: Theme.of(context).textTheme.headline2),
              Text('권오민', style: Theme.of(context).textTheme.headline2),
              Text('조승빈', style: Theme.of(context).textTheme.headline2),
              Text('신혜민', style: Theme.of(context).textTheme.headline2),
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
                Text('로그아웃', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('정말 로그아웃 하시겠습니까?',
                    style: TextStyle(fontSize: 14, color: Colors.white54)),
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
