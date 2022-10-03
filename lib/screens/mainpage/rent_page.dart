import 'package:flutter/material.dart';

import '../../widgets/default_page_widget.dart';
import '../../widgets/rent/button_page.dart';
import '../../widgets/rent/item_list_view.dart';
import 'notice_page.dart';
import '../scan_page.dart';

class RentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appBarTitle: "물품",
      appBarHasPrevious: true,
      appBarActions: [Image.asset("assets/images/search.png")],
      content: NoticeTabBar(
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
      contents: [RentItemListView(), RentItemListView(), RentItemListView()],
    );
  }
}
