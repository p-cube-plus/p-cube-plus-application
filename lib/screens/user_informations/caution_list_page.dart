import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/warning_provider.dart';

import '../../widgets/common/list_divider.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';

String _autoFix(double d) {
  if (d.toInt() == d)
    return d.toInt().toString();
  else
    return d.toString();
}

class CautionListPage extends StatelessWidget {
  const CautionListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var warningProvider = WarningProvider();

    return DefaultPage(
      title: "경고 현황",
      appbar: DefaultAppBar(),
      content: DefaultContent(
        child: Column(
          children: [
            CautionSummaryView(warningProvider: warningProvider),
            ListDivider(vertial: 24.0),
            CautionListView(
              title: "경고 및 주의 내역",
              warningProvider: warningProvider,
              mode: 1,
            ),
            SizedBox(height: 32.0),
            CautionListView(
              title: "경고 차감 내역",
              warningProvider: warningProvider,
              mode: -1,
            ),
          ],
        ),
      ),
    );
  }
}

class CautionListView extends StatelessWidget {
  const CautionListView({
    Key? key,
    required this.warningProvider,
    required this.mode,
    required this.title,
  }) : super(key: key);

  final String title;
  final int mode;
  final WarningProvider warningProvider;

  @override
  Widget build(BuildContext context) {
    List<Widget> _cautions = <Widget>[];

    warningProvider.update();
    var warningList = mode == 1
        ? warningProvider.warning?.warningAddList
        : warningProvider.warning?.warningRemoveList;

    for (var warning in warningList!) {
      String type =
          warningProvider.warning!.warningCategory[warning.category].toString();

      _cautions.add(SizedBox(height: 8.0));
      _cautions.add(
        RoundedBorder(
          padding: const EdgeInsets.all(16.0),
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$type",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    "$type 사유: ${warning.description}",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
              Text(
                "${warning.date}",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    if (_cautions.length == 0) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
        ),
      ]..addAll(_cautions),
    );
  }
}

class CautionSummaryView extends StatelessWidget {
  const CautionSummaryView({
    Key? key,
    required this.warningProvider,
  }) : super(key: key);

  final WarningProvider warningProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "주의 및 경고",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            Text(
              "${_autoFix(warningProvider.warningAddCount)}회",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "경고 차감",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            Text(
              "${_autoFix(warningProvider.warningRemoveCount)}회",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "총",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              "${_autoFix(warningProvider.warning!.warningTotal)}회",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
            )
          ],
        ),
      ],
    );
  }
}
