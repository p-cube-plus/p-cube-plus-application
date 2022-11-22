import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/rent/rent_search_list_view.dart';
import 'package:p_cube_plus_application/widgets/rounded_border_widget.dart';

import '../../widgets/default_page_widget.dart';
import '../../widgets/rent/rent_item_list_view.dart';

class RentSearchPage extends StatefulWidget {
  @override
  State<RentSearchPage> createState() => _RentSearchPageState();
}

class _RentSearchPageState extends State<RentSearchPage> {
  String _productName = "";

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appBarTitle: "검색",
      appBarHasPrevious: true,
      scrollable: false,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              RoundedBorder(
                radius: 50.0,
                color: Theme.of(context).inputDecorationTheme.fillColor,
                hasShadow: false,
                padding: EdgeInsets.only(left: 16.0),
                child: TextField(
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  //onChanged:
                  onSubmitted: (value) {
                    setState(() {
                      _productName = value;
                    });
                  },
                  textInputAction: TextInputAction.search,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                  decoration: InputDecoration(
                    hintText: "물품 이름, 종류 등",
                    hintStyle: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffixIcon: Image.asset(
                      "assets/images/search.png",
                      color: Theme.of(context).textTheme.headline3!.color,
                      scale: 1.2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              RentSearchListView(productName: _productName),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: RentButton(text: "대여하기", isActive: true),
          ),
        ],
      ),
    );
  }
}
