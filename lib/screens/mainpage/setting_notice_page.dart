import 'package:flutter/material.dart';

import '../../providers/setting_provider.dart';
import '../../widgets/setting/divider_widget.dart';
import '../../widgets/setting/maintitle_tile.dart';
import '../../widgets/setting/subtext_tile.dart';
import '../../widgets/setting/switch_tile.dart';

class SettingNoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          tooltip: '뒤로 가기',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
            physics: NeverScrollableScrollPhysics(),
            //addAutomaticKeepAlives: false,
            children: [
              MainTitleTile(title: '알림 설정'),
              SwitchTile(title: '전체 알림', type: SettingType.AllNotice),
              SettingDivider(),
              SubTextTile(title: '회비 알림'),
              SwitchTile(title: '정기회의 알림', type: SettingType.AllMeetingNotice),
              SwitchTile(title: '파트회의 알림', type: SettingType.PartMeetingNotice),
              SettingDivider(),
              SubTextTile(title: '기타 알림'),
              SwitchTile(title: '회비 알림', type: SettingType.DuesNotice),
              SwitchTile(title: '청소 알림', type: SettingType.CleanNotice),
              SwitchTile(title: '도서 대여 알림', type: SettingType.BookNotice),
            ],
          ),
        ),
      ),
    );
  }
}
