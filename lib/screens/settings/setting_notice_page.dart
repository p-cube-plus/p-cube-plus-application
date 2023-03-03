import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/default/default_appbar.dart';
import 'package:p_cube_plus_application/widgets/default/default_content.dart';
import 'package:p_cube_plus_application/widgets/default/list_divider.dart';
import 'package:provider/provider.dart';

import '../../providers/setting_provider.dart';
import '../../widgets/default/default_page.dart';
import '../../widgets/setting/subtext_tile.dart';
import '../../widgets/setting/switch_tile.dart';

class SettingNoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noticeProvider = Provider.of<SettingProvider>(context);
    noticeProvider.changeState(SettingType.AllNotice);
    return DefaultPage(
      title: "알림 설정",
      appbar: DefaultAppBar(),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchTile(title: '알림 허용', type: SettingType.AllNotice),
        ]..addAll(noticeProvider.isOn
            ? [
                (ListDivider(horizontal: 20)),
                (SubTextTile(title: '회비 알림')),
                (SwitchTile(
                    title: '정기회의 알림', type: SettingType.AllMeetingNotice)),
                (SwitchTile(
                    title: '파트회의 알림', type: SettingType.PartMeetingNotice)),
                (ListDivider(horizontal: 20)),
                (SubTextTile(title: '기타 알림')),
                (SwitchTile(title: '회비 알림', type: SettingType.DuesNotice)),
                (SwitchTile(title: '청소 알림', type: SettingType.CleanNotice)),
                (SwitchTile(title: '도서 대여 알림', type: SettingType.BookNotice)),
              ]
            : [SizedBox()]),
      ),
    );
  }
}
