import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_setting/bottom_sheet/development_list_bottom_sheet.dart';
import 'package:presentation/ui/user/user_setting/developer_setting_page/developer_page.dart';
import 'package:presentation/ui/user/user_setting/setting_tile/right_arrow_setting_tile.dart';
import 'package:presentation/ui/user/user_setting/setting_tile/setting_tile.dart';
import 'package:presentation/ui/user/user_setting/setting_tile/theme_setting_tile.dart';
import 'package:presentation/ui/user/user_setting/setting_tile/version_setting_tile.dart';
import 'package:presentation/ui/user/user_setting/user_alarm/user_alarm_page.dart';
import 'package:presentation/ui/user/user_setting/user_setting_view_model.dart';
import 'package:presentation/widgets/default_alert.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_bottomsheet.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:provider/provider.dart';

class UserSettingPage extends StatelessWidget {
  const UserSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserSettingViewModel(),
      child: _UserSettingPage(),
    );
  }
}

class _UserSettingPage extends StatelessWidget
    with ViewModel<UserSettingViewModel> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(),
      title: "설정",
      content: Column(
        children: [
          RightArrowSettingTile(
            title: "알림 설정",
            onTap: (context) => navigateToUserAlarmSettingPage(context),
          ),
          ThemeSettingTile(),
          Divider(
            color: theme.neutral10,
            indent: 20,
            endIndent: 20,
          ),
          VersionSettingTile(),
          RightArrowSettingTile(
            title: "PCube+에 피드백 보내기",
          ),
          RightArrowSettingTile(
            title: "개발진 목록",
            onTap: (context) => _showDevelopmentList(context),
          ),
          Divider(
            color: theme.neutral10,
            indent: 20,
            endIndent: 20,
          ),
          SettingTile(
            title: "로그아웃",
            onTap: (context) => _showLogoutDialog(context),
          ),
          SettingTile(
            title: "회원탈퇴",
          ),
          if (kDebugMode)
            RightArrowSettingTile(
              title: "개발자 설정",
              onTap: (context) => _navigateToDeveloperPage(context),
            ),
        ],
      ),
    );
  }

  void navigateToUserAlarmSettingPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => UserAlarmPage()));
  }

  void _showDevelopmentList(BuildContext context) {
    BottomSheetBuilder().build(
      context,
      DevelopmentListBottomSheet(
        listData: read(context).fetchDevelopmentList(),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    DialogBuilder().build(
      context,
      DefaultAlert(
        title: "로그아웃",
        description: "정말 로그아웃 하시겠어요?",
        messageType: MessageType.okCancel,
      ),
    );
  }

  void _navigateToDeveloperPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DeveloperPage(),
      ),
    );
  }
}
