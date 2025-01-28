import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_logout_complete/user_logout_complete_page.dart';
import 'package:presentation/ui/user/user_setting/bottom_sheet/delete_user_bottom_sheet/delete_user_bottom_sheet.dart';
import 'package:presentation/ui/user/user_setting/bottom_sheet/development_list_bottom_sheet.dart';
import 'package:presentation/ui/user/user_setting/developer_setting_page/developer_page.dart';
import 'package:presentation/ui/user/user_setting/setting_tile/right_arrow_setting_tile.dart';
import 'package:presentation/ui/user/user_setting/setting_tile/setting_tile.dart';
import 'package:presentation/ui/user/user_setting/setting_tile/theme_setting_tile.dart';
import 'package:presentation/ui/user/user_setting/setting_tile/version_setting_tile.dart';
import 'package:presentation/ui/user/user_setting/notification_setting/notification_setting_page.dart';
import 'package:presentation/ui/user/user_setting/user_setting_event.dart';
import 'package:presentation/ui/user/user_setting/user_setting_view_model.dart';
import 'package:presentation/ui/webpage/introduce_p_cube_web_page.dart';
import 'package:presentation/widgets/default_alert.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_bottomsheet.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_progress_indicator_builder.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

class _UserSettingPage extends StatefulWidget {
  @override
  State<_UserSettingPage> createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<_UserSettingPage>
    with ViewModel<UserSettingViewModel> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => _setEventListener());
  }

  void _setEventListener() {
    read(context).eventStream.listen((event) {
      switch (event) {
        case OnSuccessLogoutEvent():
          _navigateToLogoutCompletePage();
        case ShowToastMessage():
          Fluttertoast.showToast(msg: event.message);
        case DismissLoadingDialog():
          _dismissLoadingDialog();
      }
    });
  }

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
            onTap: (context) => navigateToUserAlarmSettingPage(),
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
            onTap: (context) => _goToMailAppLink(),
          ),
          RightArrowSettingTile(
            title: "개발진 목록",
            onTap: (context) => _showDevelopmentList(),
          ),
          RightArrowSettingTile(
            title: "판도라큐브 소개 보기",
            onTap: (context) => _navigateToIntroduceWebPage(),
          ),
          Divider(
            color: theme.neutral10,
            indent: 20,
            endIndent: 20,
          ),
          SettingTile(
            title: "로그아웃",
            onTap: (context) => _showLogoutDialog(),
          ),
          SettingTile(
            title: "회원탈퇴",
            onTap: (context) => _showDeleteUserBottomSheet(),
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

  void navigateToUserAlarmSettingPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => NotificationSettingPage()));
  }

  void _showDevelopmentList() {
    BottomSheetBuilder().build(
      context,
      DevelopmentListBottomSheet(
        listData: read(context).fetchDevelopmentList(),
      ),
    );
  }

  void _showLogoutDialog() {
    DialogBuilder().build(
      context,
      DefaultAlert(
        title: "로그아웃",
        description: "정말 로그아웃 하시겠어요?",
        messageType: MessageType.okCancel,
        onTapOk: () {
          read(context).logout();
          Future.microtask(() {
            if (context.mounted) {
              DefaultProgressIndicatorBuilder().build(context);
            }
          });
        },
        okString: "로그아웃",
      ),
    );
  }

  void _dismissLoadingDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  void _navigateToLogoutCompletePage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => UserLogoutCompletePage(),
      ),
      (route) => false,
    );
  }

  void _showDeleteUserBottomSheet() {
    BottomSheetBuilder().build(context, DeleteUserBottomSheet());
  }

  void _navigateToDeveloperPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DeveloperPage(),
      ),
    );
  }

  void _navigateToIntroduceWebPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => IntroducePCubeWebPage(),
      ),
    );
  }

  void _goToMailAppLink() async {
    const mailScheme = "mailto";
    const email = "pcube.team.vent@gmail.com";
    const subject = "[불편신고][PCube+]";
    const body = "";

    final url = Uri(
      scheme: mailScheme,
      path: email,
      query: {
        'subject': subject,
        'body': body,
      }
          .entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&'),
    );

    final canLaunch = await canLaunchUrl(url);

    if (canLaunch) {
      await launchUrl(url);
    } else {
      Fluttertoast.showToast(
        msg: "실행할 수 있는 메일앱이 없습니다.",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
