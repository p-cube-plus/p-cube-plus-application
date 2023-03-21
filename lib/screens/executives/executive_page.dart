import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/executives/notification/executive_notification_page.dart';
import 'package:p_cube_plus_application/widgets/default/default_appbar.dart';
import 'package:p_cube_plus_application/widgets/default/default_content.dart';
import 'package:p_cube_plus_application/widgets/default/default_page.dart';
import 'package:p_cube_plus_application/widgets/default/rounded_border.dart';
import '../../utilities/contants.dart' as Constants;

class ExecutivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(),
      title: "임원진",
      subtitle: "임원진 전용 메뉴입니다.",
      content: DefaultContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getButton(context, Constants.Icons.executives_alarm, "알림",
                    ExecutiveNotificationPage()),
                SizedBox(width: 16),
                _getButton(context, Constants.Icons.executives_fee, "회비", null),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getButton(
                    context, Constants.Icons.executives_member, "회원관리", null),
                SizedBox(width: 16),
                _getButton(
                    context, Constants.Icons.executives_product, "물품", null),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getButton(
                    context, Constants.Icons.executives_feedback, "문의내역", null),
                Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getButton(context, String icon, String text, page) {
    return Expanded(
      child: RoundedBorder(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        ),
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 32, height: 32, child: Constants.Icons.GetIcon(icon)),
            SizedBox(height: 8),
            Text(
              text,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
