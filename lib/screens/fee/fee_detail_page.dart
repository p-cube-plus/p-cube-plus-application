import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/models/due.dart';
import 'package:p_cube_plus_application/widgets/rounded_border_widget.dart';
import 'package:provider/provider.dart';
import '../../providers/fee_provider.dart';
import '../../widgets/default_page_widget.dart';
import '../../widgets/list_divider_widget.dart';
import '../../utilities/contants.dart' as Constants;

class FeeDetailPage extends StatelessWidget {
  static FeeType feeType = FeeType.All;

  @override
  Widget build(BuildContext context) {
    final feeProvider = Provider.of<FeeProvider>(context);

    return DefaultPage(
      appBarTitle: "회비 내역",
      appBarTitleColor: Colors.white,
      appBarHasPrevious: true,
      scrollable: false,
      backgroundColor: const Color(0xFFDE2B13),
      subtitleColor: Colors.white,
      previousButtonColor: Colors.white,
      padding: 0,
      appBarPadding: EdgeInsets.symmetric(vertical: 20),
      appBarActions: [
        GestureDetector(
          onTap: () => showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              builder: (context) => _getBottomsheetData(context, feeProvider)),
          child: Row(
            children: [
              Text(
                feeProvider.type == FeeType.All
                    ? "전체"
                    : feeProvider.type == FeeType.Deposit
                        ? "입금"
                        : "출금",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              )
            ],
          ),
        )
      ],
      content: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).backgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccountInfo(),
                DuesDetail(
                  type: feeProvider.type,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getBottomsheetData(context, feeProvider) {
    feeProvider = Provider.of<FeeProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, top: 32, bottom: 40),
          child: Text(
            "내역 유형",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 20.0, fontWeight: FontWeight.w700),
          ),
        ),
        _getBottomTile(context, FeeType.All, feeProvider),
        _getBottomTile(context, FeeType.Deposit, feeProvider),
        _getBottomTile(context, FeeType.Withdraw, feeProvider),
        SizedBox(height: 56)
      ],
    );
  }

  _getBottomTile(context, FeeType type, FeeProvider feeProvider) {
    return InkWell(
      onTap: () => feeProvider.changeType(type),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              type == FeeType.All
                  ? "전체"
                  : type == FeeType.Deposit
                      ? "입금"
                      : "출금",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 16.0, fontWeight: FontWeight.w400),
            ),
            Radio(
                activeColor: const Color(0xFFDE2B13),
                value: type,
                groupValue: feeProvider.type,
                onChanged: (value) => feeProvider.changeType(type))
          ],
        ),
      ),
    );
  }
}

class AccountInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      radius: BorderRadius.circular(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Center(
              child: Text(
                "1,200,340원",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          ListDivider(padding: 24),
          Padding(
            padding: EdgeInsets.only(bottom: 24, left: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "회비계좌",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
                GestureDetector(
                  onTap: () => Clipboard.setData(
                      ClipboardData(text: "카카오뱅크 1234-5678-90")),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          "카카오뱅크",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          "1234-5678-90 정성희",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Constants.Icons.GetIcon(Constants.Icons.copy)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DuesDetail extends StatelessWidget {
  const DuesDetail({required this.type});

  final FeeType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var due = <Due>[
      new Due(date: new DateTime(2023, 10, 8), name: "게임잼 상품", charge: -300000),
      new Due(date: new DateTime(2023, 10, 8), name: "게임잼 상품", charge: -300000),
      new Due(date: new DateTime(2023, 9, 2), name: "9월 회비 정산", charge: 300000),
      new Due(date: new DateTime(2023, 8, 7), name: "8월 회비 정산", charge: 300000),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: Column(
            children: [
              _getDueList(theme, due, type),
            ],
          ),
        ),
      ],
    );
  }

  _getDueList(theme, List<Due> due, FeeType type) {
    var prevDate = due[0].date;
    var dueList = <List<Due>>[];
    var dueItemList = <Due>[];

    for (int i = 0; i < due.length; ++i) {
      if (prevDate.day != due[i].date.day ||
          prevDate.month != due[i].date.month) {
        if (dueItemList.length > 0) dueList.add(dueItemList);
        dueItemList = <Due>[];
      }
      if (type == FeeType.All ||
          (type == FeeType.Deposit && due[i].charge > 0) ||
          (type == FeeType.Withdraw && due[i].charge < 0)) {
        prevDate = due[i].date;
        dueItemList.add(due[i]);
      }
    }
    if (dueItemList.length > 0) dueList.add(dueItemList);

    return Column(
      children: [
        for (int i = 0; i < dueList.length; ++i)
          Padding(
            padding: EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    DateFormat('M월 d일').format(dueList[i][0].date),
                    style: theme.textTheme.headline2!
                        .copyWith(fontSize: 12.0, fontWeight: FontWeight.w400),
                  ),
                ),
                RoundedBorder(
                    radius: BorderRadius.all(Radius.circular(10)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        children: [
                          _getDueListItem(theme, dueList[i]),
                        ],
                      ),
                    )),
              ],
            ),
          ),
      ],
    );
  }

  Widget _getDueListItem(ThemeData theme, List<Due> dueItemList) {
    return Column(
      children: [
        for (int i = 0; i < dueItemList.length; ++i)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Constants.Icons.GetIcon(Constants.Icons.pcube_logo),
                  ),
                  Text(dueItemList[i].name),
                ],
              ),
              Text(NumberFormat('###,###,###원').format(dueItemList[i].charge),
                  style: theme.textTheme.headline1!.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: dueItemList[i].charge > 0
                        ? Colors.green
                        : theme.textTheme.headline1!.color,
                  )),
            ],
          ),
      ],
    );
  }
}
