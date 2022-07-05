import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../models/seminar.dart';
import '../../providers/user_data.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../../widgets/list_divider_widget.dart';
import '../../widgets/default_page_widget.dart';
import '../../widgets/rounded_border_widget.dart';
import 'user_information_page.dart';

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
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Color(0xFF818181),
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
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: const Color(0xFF2E2E2E),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                    Text(
                      "${DateFormat("yyyy/MM/dd").format(seminar.date)}", // debug
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: const Color(0xFFABABAB),
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

class SeminarSummaryView extends StatelessWidget {
  const SeminarSummaryView({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    Map<int, int> _count = {};
    for (var seminar in userProvider.user!.seminars) {
      _count[seminar.date.year] = (_count[seminar.date.year] ?? 0) + 1;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_count.length, (index) {
        List<int> years = _count.keys.toList();
        years.sort();

        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Text(
                "${years[index]}년 세미나 참여",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black.withAlpha(0xDE),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
              ),
              SizedBox(width: 16.0),
              Text(
                "${_count[years[index]]}회",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black.withAlpha(0xDE),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
