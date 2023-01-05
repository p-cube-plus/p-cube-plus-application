import 'package:flutter/material.dart';

import '../../widgets/default_page_widget.dart';
import '../../widgets/rent/button_page.dart';
import '../../widgets/rent/rent_item_list_view.dart';
import '../../widgets/tabbar/custom_tab_bar._widget.dart';
import 'rent_search_page.dart';
import '../mainpage/notice_page.dart';
import 'scan_page.dart';

class RentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appBarTitle: "물품",
      appBarHasPrevious: true,
      appBarActions: [
        //체크
        GestureDetector(
          child: Image.asset("assets/images/search.png"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RentSearchPage(),
              ),
            );
          },
        ),
      ],
      content: CustomTabBar(
        tabs: ["대여하기", "내가 대여한"],
        pages: [
          RentItemView(),
          RentedItemListView(),
        ],
      ),
    );
  }
}

class RentItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonPage(
      names: ["전체", "대여 가능", "대여 중"],
      contents: [
        RentItemListView(isActive: true),
        RentItemListView(isActive: true),
        RentItemListView(isActive: false)
      ],
    );
  }
}
