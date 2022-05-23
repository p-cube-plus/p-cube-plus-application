import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:p_cube_plus_application/widgets/icon_widget.dart';

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
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 0),
            children: [
              SettingsGroup(
                title: "그룹1",
                children: [
                  DarkMode(),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ));
  }
}

class DarkMode extends StatelessWidget {
  static const keyDarkMode = "key-dark-mode";
  @override
  Widget build(BuildContext context) {
    return SwitchSettingsTile(
      title: "다크모드",
      settingKey: keyDarkMode,
      leading: IconWidget(
        icon: Icons.dark_mode,
        color: Color(0xFF642ef3),
      ),
      onChange: (_) {},
    );
  }
}
