import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:p_cube_plus_application/widgets/icon_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        automaticallyImplyLeading: false,
        //leading: IconButton(
        //  icon: const Icon(Icons.arrow_back),
        //  color: Color.fromARGB(255, 0, 0, 0),
        //  tooltip: '뒤로 가기',
        //  onPressed: () {
        //    Navigator.pop(context);
        //  },
        //),
      ),
      body: Container(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
            physics: NeverScrollableScrollPhysics(),
            //addAutomaticKeepAlives: false,
            children: [
              NoticeSetting(),
              DarkModeSetting(),
              const Divider(
                height: 40,
              ),
              VersionSetting(),
              const SizedBox(
                height: 15,
              ),
              FeedbackSetting(),
              const SizedBox(
                height: 15,
              ),
              DevTeamSetting(),
              const Divider(
                height: 40,
              ),
              LogoutSetting(),
              //const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class DarkModeSetting extends StatelessWidget {
  static const keyDarkMode = "key-dark-mode";
  @override
  Widget build(BuildContext context) {
    return SwitchSettingsTile(
      title: "테마",
      settingKey: keyDarkMode,
      onChange: (_) {},
    );
  }
}

class NoticeSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      title: "알림",
      subtitle: '',
      child: NoticeSettingScreen(),
      onTap: () {},
    );
  }
}

class VersionSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<PackageInfo>(
        future: _getPackageInfo(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Text('ERROR');
          } else if (!snapshot.hasData) {
            return const Text('Loading...');
          }

          final data = snapshot.data!;
          return SimpleSettingsTile(
            title: "버전",
            enabled: false,
            subtitle: data.version,
            onTap: () {},
          );
        },
      ),
    );
  }
}

Future<PackageInfo> _getPackageInfo() {
  return PackageInfo.fromPlatform();
}

class FeedbackSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      title: "피드백 보내기",
      subtitle: '',
      child: Text('준비중'),
      onTap: () {},
    );
  }
}

class DevTeamSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      title: "개발진 목록",
      subtitle: '',
      child: Text('준비중'),
      onTap: () {},
    );
  }
}

class LogoutSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      title: "로그아웃",
      subtitle: '',
      onTap: () {},
    );
  }
}

class NoticeSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('알림 설정'),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            children: [
              SwitchSettingsTile(
                title: "전체 알림",
                onChange: (_) {},
                settingKey: '1',
              ),
              SettingsGroup(
                title: "회비 알림",
                children: [
                  SwitchSettingsTile(
                    title: "정기회의 알림",
                    onChange: (_) {},
                    settingKey: '2',
                  ),
                  SwitchSettingsTile(
                    title: "파트회의 알림",
                    onChange: (_) {},
                    settingKey: '3',
                  ),
                ],
              ),
              SettingsGroup(
                title: "기타 알림",
                children: [
                  SwitchSettingsTile(
                    title: "회비 알림",
                    onChange: (_) {},
                    settingKey: '4',
                  ),
                  SwitchSettingsTile(
                    title: "청소 알림",
                    onChange: (_) {},
                    settingKey: '5',
                  ),
                  SwitchSettingsTile(
                    title: "도서 대여 알림",
                    onChange: (_) {},
                    settingKey: '6',
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
