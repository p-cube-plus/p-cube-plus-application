import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/default/default_appbar.dart';
import 'package:p_cube_plus_application/widgets/default/default_content.dart';
import 'package:p_cube_plus_application/widgets/default/default_page.dart';
import 'package:p_cube_plus_application/widgets/executive/notification/required_text.dart';

import '../../../widgets/executive/notification/notifitation_input.dart';
import '../../../widgets/executive/notification/set_notification.dart';

class RegularMettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: "정기회의 알림",
      ),
      content: DefaultContent(
        bottomButtonText: "확인",
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SetNotification(),
            SizedBox(height: 8),
            NotificationInput(RequiredText(text: "장소")),
            SizedBox(height: 8),
            NotificationInput(RequiredText(text: "일정")),
            SizedBox(height: 8),
            NotificationInput(RequiredText(text: "메모", isRequired: false)),
          ],
        ),
      ),
    );
  }
}
