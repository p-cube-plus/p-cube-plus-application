import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/guest/guest_setting_page.dart';
import 'package:presentation/ui/webpage/introduce_p_cube_web_page.dart';
import 'package:presentation/ui/login/login_home_bottomsheet/login_home_bottomsheet.dart';
import 'package:presentation/widgets/default_bottomsheet.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/constants/asset_path.dart' as asset;
import 'package:presentation/widgets/default_profile.dart';

class GuestUserPage extends StatefulWidget {
  const GuestUserPage({super.key});

  @override
  State<GuestUserPage> createState() => _UserPageState();
}

class _UserPageState extends State<GuestUserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    return DefaultPage(
      title: "내 정보",
      action: GestureDetector(
        onTap: () => _navigateToUserSettingPage(context),
        child: SvgPicture.asset(asset.setting),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                DefaultProfile(size: 72),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Guest",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: theme.neutral100,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(
              height: 1,
              color: theme.neutral10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Guest 모드로 접속했어요!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: theme.neutral80,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "PCube+의 서비스를 이용하고 싶다면\n먼저  판도라큐브 동아리의 회원이어야 해요.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: theme.neutral40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () => _showBottomSheet(context),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Text(
                            "PCube+ 시작하기",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () => _navigateToPCubeIntroducePage(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        "판도라큐브 소개 바로가기",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.neutral60,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPCubeIntroducePage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => IntroducePCubeWebPage(),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    BottomSheetBuilder().build(
      context,
      const LoginHomeBottomsheet(),
    );
  }

  void _navigateToUserSettingPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GuestSettingPage(),
      ),
    );
  }
}
