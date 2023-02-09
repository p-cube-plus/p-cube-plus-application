import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/rounded_border_widget.dart';
import '../../widgets/default_page_widget.dart';
import '../../widgets/list_divider_widget.dart';

class FeeDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        Row(
          children: [Text("전체"), Icon(Icons.keyboard_arrow_down)],
        )
      ],
      content: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [AccountInfo(), DuesDetail()],
          ),
        ),
      ),
    );
  }
}

class AccountInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      radius: 10,
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
                Text(
                  "카카오뱅크 1234-5678-90 정성희",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  "10월 8일",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: RoundedBorder(
                    radius: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("게임잼 상품"),
                        Text("300,000원"),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
