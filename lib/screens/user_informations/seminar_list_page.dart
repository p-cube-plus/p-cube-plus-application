import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../models/seminar.dart';
import '../../providers/user_data.dart';
import '../../widgets/default_page_widget.dart';
import '../../widgets/rounded_border_widget.dart';

class SeminarListPage extends StatelessWidget {
  const SeminarListPage({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Theme.of(context).backgroundColor,
      ),
    );

    return DefaultPage(
      appBarTitle: "세미나 내역",
      appBarHasPrevious: true,
      content: (userProvider.user!.seminars.length == 0)
          ? Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "세미나 참여 내역이 존재하지 않습니다.",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            )
          : SeminarListView(userProvider: userProvider),
    );
  }
}

class SeminarListView extends StatelessWidget {
  const SeminarListView({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        userProvider.user!.seminars.length,
        (index) {
          Seminar seminar = userProvider.user!.seminars[index];

          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: RoundedBorder(
              radius: 10.0,
              height: 48.0,
              hasShadow: true,
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${["수습회원", "정회원", "졸업생"][seminar.type]} 세미나", // debug
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      "${DateFormat("yyyy/MM/dd").format(seminar.date)}", // debug
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
