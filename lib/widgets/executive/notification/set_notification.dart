import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/executive/notification/required_text.dart';
import '../../default/rounded_border.dart';

class SetNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return RoundedBorder(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RequiredText(text: "알람 일정"),
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "매주",
                style: textTheme.headline5!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8),
              Column(
                children: [
                  Text(
                    "일",
                    style: textTheme.headline3!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "월",
                    style: textTheme.headline1!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "화",
                    style: textTheme.headline3!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
              Text(
                "요일",
                style: textTheme.headline5!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 32),
              Column(
                children: [
                  Text(
                    "12",
                    style: textTheme.headline3!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "13",
                    style: textTheme.headline1!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "14",
                    style: textTheme.headline3!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
              Text("시"),
              SizedBox(width: 16),
              Column(
                children: [
                  Text(
                    "12",
                    style: textTheme.headline3!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "13",
                    style: textTheme.headline1!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "14",
                    style: textTheme.headline3!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
              Text("분"),
            ],
          ),
        ],
      ),
    );
  }
}
