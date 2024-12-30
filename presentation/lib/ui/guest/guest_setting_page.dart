import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/login/login_home/login_home_page.dart';
import 'package:presentation/ui/user/user_setting/bottom_sheet/development_list_bottom_sheet.dart';
import 'package:presentation/ui/user/user_setting/developer_setting_page/developer_page.dart';
import 'package:presentation/ui/user/user_setting/setting_tile/right_arrow_setting_tile.dart';
import 'package:presentation/ui/user/user_setting/setting_tile/theme_setting_tile.dart';
import 'package:presentation/ui/user/user_setting/setting_tile/version_setting_tile.dart';
import 'package:presentation/ui/user/user_setting/user_setting_view_model.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_bottomsheet.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:provider/provider.dart';

class GuestSettingPage extends StatelessWidget {
  const GuestSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserSettingViewModel(),
      child: _GuestSettingPage(),
    );
  }
}

class _GuestSettingPage extends StatefulWidget {
  @override
  State<_GuestSettingPage> createState() => _GuestSettingPageState();
}

class _GuestSettingPageState extends State<_GuestSettingPage>
    with ViewModel<UserSettingViewModel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(),
      title: "설정",
      content: Column(
        children: [
          ThemeSettingTile(),
          Divider(
            color: theme.neutral10,
            indent: 20,
            endIndent: 20,
          ),
          VersionSettingTile(),
          RightArrowSettingTile(
            title: "개발진 목록",
            onTap: (context) => _showDevelopmentList(),
          ),
          Divider(
            color: theme.neutral10,
            indent: 20,
            endIndent: 20,
          ),
          RightArrowSettingTile(
            title: "로그인 화면으로 돌아가기",
            onTap: (context) => _navigateToLoginPage(),
          ),
          if (kDebugMode)
            RightArrowSettingTile(
              title: "개발자 설정",
              onTap: (context) => _navigateToDeveloperPage(),
            ),
        ],
      ),
    );
  }

  void _showDevelopmentList() {
    BottomSheetBuilder().build(
      context,
      DevelopmentListBottomSheet(
        listData: read(context).fetchDevelopmentList(),
      ),
    );
  }

  void _navigateToLoginPage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => LoginHomePage(),
      ),
      (route) => false,
    );
  }

  void _navigateToDeveloperPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DeveloperPage(),
      ),
    );
  }
}
