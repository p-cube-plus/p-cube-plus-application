import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/models/warning.dart';
import 'package:p_cube_plus_application/providers/api_provider/warning_provider.dart';
import 'package:p_cube_plus_application/widgets/common/default_futureBuilder.dart';
import 'package:p_cube_plus_application/widgets/common/default_refreshIndicator.dart';
import 'package:provider/provider.dart';

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
    var warningProvider = context.watch<WarningProvider>();

    return DefaultRefreshIndicator(
      refreshFunction: warningProvider.refresh,
      child: DefaultFutureBuilder(
        fetchData: warningProvider.fetch(),
        showFunction: (Warning warning) => DefaultPage(
          title: "경고 현황",
          appbar: DefaultAppBar(),
          content: DefaultContent(
            child: Column(
              children: [
                CautionSummaryView(warning: warning),
                ListDivider(vertial: 24.0),
                CautionListView(
                  title: "경고 및 주의 내역",
                  warning: warning,
                  mode: 1,
                ),
                SizedBox(height: 32.0),
                CautionListView(
                  title: "경고 차감 내역",
                  warning: warning,
                  mode: -1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CautionListView extends StatelessWidget {
  const CautionListView({
    Key? key,
    required this.warning,
    required this.mode,
    required this.title,
  }) : super(key: key);

  final String title;
  final int mode;
  final Warning warning;

  @override
  Widget build(BuildContext context) {
    List<Widget> _cautions = <Widget>[];

    var warningList =
        mode == 1 ? warning.warningAddList : warning.warningRemoveList;

    for (var warningInfo in warningList) {
      String type = warning.warningCategory[warningInfo.category].toString();

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
                    "$type 사유: ${warningInfo.description}",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
              Text(
                "${warningInfo.date}",
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
    required this.warning,
  }) : super(key: key);

  final Warning warning;

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
              "${warning.totalAddWarning}회",
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
              "${warning.totalRemoveWarning}회",
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
              "${warning.totalWarning}회",
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
