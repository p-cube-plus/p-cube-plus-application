import 'package:flutter/material.dart';
import 'package:presentation/widgets/defauilt_toggle_tile.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';

class ExecutiveAlarmSettingPage extends StatelessWidget {
  const ExecutiveAlarmSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: "정기회의 알림",
      ),
      content: DefaultContent(
        child: Column(
          children: [
            DefauiltToggleTile(
              title: "알림 켜짐",
              value: true,
              onChanged: (bool isOn) {},
            ),
          ],
        ),
      ),
    );
  }
}
