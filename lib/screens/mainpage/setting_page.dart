import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/setting_provider.dart';
import 'package:p_cube_plus_application/widgets/default_page_widget.dart';
import 'package:p_cube_plus_application/widgets/setting/divider_widget.dart';
import 'package:p_cube_plus_application/widgets/setting/new_page_tile.dart';
import 'package:p_cube_plus_application/widgets/setting/switch_tile.dart';

import '../../widgets/alert_frame.dart';
import '../../widgets/list_divider_widget.dart';
import '../../widgets/setting/alert_tile.dart';
import '../../widgets/setting/maintitle_tile.dart';
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
          ListDivider(padding: 20.0),
          VersionTile(title: '버전'),
          AlertTile(
              title: '피드백 보내기', hasIcon: true, alertWidget: _getFeedback()),
          AlertTile(title: '개발진 목록', hasIcon: true, alertWidget: _getDev()),
          ListDivider(padding: 20.0),
          AlertTile(title: '로그아웃', hasIcon: false, alertWidget: _getLogout()),
        ],
      ),
    );
  }

  _getFeedback() {
    return AlertFrame(
      title: Text(
        '피드백 보내기',
        style: TextStyle(fontSize: 18),
      ),
      messageType: MessageType.OKCancel,
      children: [
        TextField(
          decoration: InputDecoration(
              labelText: '이름을 입력하세요',
              border: OutlineInputBorder(),
              fillColor: Colors.white10),
          scrollPadding: EdgeInsets.all(20.0),
        ),
        SizedBox(height: 15),
        TextField(
          maxLines: 10,
          maxLength: 200,
          decoration: InputDecoration(
              labelText: '내용을 입력하세요', border: OutlineInputBorder()),
          scrollPadding: EdgeInsets.all(20.0),
          textAlign: TextAlign.start,
        ),
      ],
      okWidget: _getOKFeedback(),
    );
  }

  _getOKFeedback() {
    return AlertFrame(
      title: Align(
        child: Column(
          children: [
            SizedBox(height: 15),
            Text('피드백이 제출되었습니다!', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('소중한 의견 감사합니다.',
                style: TextStyle(fontSize: 15, color: Colors.white54)),
          ],
        ),
        alignment: Alignment.center,
      ),
      messageType: MessageType.OK,
      children: [],
    );
  }

  _getDev() {
    return AlertFrame(
      title: Column(
        children: [
          Align(
            child: Text('개발진 목록'),
            alignment: Alignment.centerLeft,
          ),
          SizedBox(height: 3),
          Align(
            child: Text('PCube+의 개발진 목록입니다.',
                style: TextStyle(fontSize: 14, color: Colors.white54)),
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
      messageType: MessageType.OK,
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('오창한', style: TextStyle(fontSize: 14, color: Colors.white70)),
            Text('권오민', style: TextStyle(fontSize: 14, color: Colors.white70)),
            Text('조승빈', style: TextStyle(fontSize: 14, color: Colors.white70)),
            Text('신혜민', style: TextStyle(fontSize: 14, color: Colors.white70)),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  _getLogout() {
    return AlertFrame(
      title: Align(
        child: Column(
          children: [
            SizedBox(height: 15),
            Text('로그아웃', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('정말 로그아웃 하시겠습니까?',
                style: TextStyle(fontSize: 14, color: Colors.white54)),
          ],
        ),
        alignment: Alignment.center,
      ),
      messageType: MessageType.OKCancel,
      children: [],
      okWidget: LogoutPage(),
    );
  }
}
