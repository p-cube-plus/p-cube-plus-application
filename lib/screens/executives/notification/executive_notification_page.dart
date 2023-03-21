import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/executives/notification/regular_meeting_page.dart';
import 'package:p_cube_plus_application/widgets/default/default_appbar.dart';
import 'package:p_cube_plus_application/widgets/default/default_content.dart';
import 'package:p_cube_plus_application/widgets/default/default_page.dart';
import 'package:p_cube_plus_application/widgets/default/rounded_border.dart';

class ExecutiveNotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(),
      title: "알림",
      content: DefaultContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _getButton(context, "정기회의 알림", RegularMettingPage()),
            SizedBox(height: 10),
            _getButton(context, "파트회의 알림", null),
            SizedBox(height: 10),
            _getButton(context, "회비 알림", null),
            SizedBox(height: 10),
            _getButton(context, "청소 알림", null),
            SizedBox(height: 10),
            _getButton(context, "기타 알림", null),
          ],
        ),
      ),
    );
  }

  _getButton(context, String text, page) {
    return RoundedBorder(
      padding: EdgeInsets.all(20),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
            color: Color(0xFFABABAB),
          ),
        ],
      ),
    );
  }
}
