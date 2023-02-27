import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/default/default_appbar.dart';

import '../../widgets/default/default_page.dart';
import '../../widgets/rent/rent_item_list_view.dart';
import '../../widgets/rent/rented_item_list_view.dart';
import '../../widgets/default/default_tabbar.dart';
import 'rent_search_page.dart';

class RentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "물품",
      appbar: DefaultAppBar(),
      action:
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
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DefaultTabBar(tabs: [
              DefaultTab(title: "대여하기", page: RentItenListView()),
              DefaultTab(title: "내가 대여한", page: RentedItemListView())
            ]),
          )
        ],
      ),
    );
  }
}
