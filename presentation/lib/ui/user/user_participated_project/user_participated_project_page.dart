import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_profile_list.dart';
import 'package:presentation/widgets/rounded_border.dart';

class UserParticipatedProjectPage extends StatelessWidget {
  const UserParticipatedProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(),
      title: "참여 프로젝트",
      content: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 10,
          itemBuilder: (context, index) {
            return RoundedBorder(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 16),
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "PCube+",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: theme.neutral100,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "메인프로젝트",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: theme.neutral100,
                        ),
                      ),
                      Text(
                        "진행중 ${DateTime.now().format("yyyy.MM.dd")} ~ ${DateTime.now().format("yyyy.MM.dd")}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: theme.neutral40,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: DefaultProfileList(
                      itemCount: 8,
                      size: 24,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
