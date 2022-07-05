import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/list_divider_widget.dart';

import '../../providers/setting_provider.dart';
import '../../widgets/default_page_widget.dart';
import '../../widgets/setting/divider_widget.dart';
import '../../widgets/setting/maintitle_tile.dart';
import '../../widgets/setting/subtext_tile.dart';
import '../../widgets/setting/switch_tile.dart';

class SettingNoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appBarTitle: "알림 설정",
      appBarHasPrevious: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //MainTitleTile(title: '알림 설정'),
          SwitchTile(title: '전체 알림', type: SettingType.AllNotice),
          ListDivider(),
          SubTextTile(title: '회비 알림'),
          SwitchTile(title: '정기회의 알림', type: SettingType.AllMeetingNotice),
          SwitchTile(title: '파트회의 알림', type: SettingType.PartMeetingNotice),
          ListDivider(),
          SubTextTile(title: '기타 알림'),
          SwitchTile(title: '회비 알림', type: SettingType.DuesNotice),
          SwitchTile(title: '청소 알림', type: SettingType.CleanNotice),
          SwitchTile(title: '도서 대여 알림', type: SettingType.BookNotice),
        ],
      ),
    );
  }
}
