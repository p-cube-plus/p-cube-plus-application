import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_participated_project/user_participated_project_list_tile.dart';
import 'package:presentation/ui/user/user_profile/user_profile_tile.dart';
import 'package:presentation/ui/user/user_setting/user_setting_page.dart';
import 'package:presentation/ui/user/user_warning/user_warning_tile.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      title: "내 정보",
      action: GestureDetector(
        onTap: () => _navigateToUserSettingPage(context),
        child: SvgPicture.asset(asset.setting),
      ),
      content: DefaultContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfileTile(),
            SizedBox(height: 20),
            Divider(
              height: 1,
              color: theme.neutral10,
            ),
            SizedBox(height: 24),
            UserWarningTile(),
            SizedBox(height: 32),
            UserParticipatedProjectListTile(),
          ],
        ),
      ),
    );
  }

  void _navigateToUserSettingPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => UserSettingPage()));
  }
}
