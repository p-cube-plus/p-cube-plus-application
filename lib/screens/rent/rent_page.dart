import 'package:flutter/material.dart';

import '../../widgets/default_page_widget.dart';
import '../../widgets/rent/rent_item_list_view.dart';
import '../../widgets/rent/rented_item_list_view.dart';
import '../../widgets/tabbar/custom_tab_bar._widget.dart';
import 'rent_search_page.dart';

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
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomTabBar(
              tabs: ["대여하기", "내가 대여한"],
              pages: [
                Expanded(child: RentItenListView()),
                Expanded(child: RentedItemListView()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
