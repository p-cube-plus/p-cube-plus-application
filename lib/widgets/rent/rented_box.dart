import 'package:flutter/material.dart';

import '../../models/rent.dart';
import '../rounded_border_widget.dart';
import 'rent_item_list_view.dart';

class RentedBox extends StatelessWidget {
  const RentedBox({
    Key? key,
    required this.rent,
  }) : super(key: key);

  static int groupNum = -1;
  final Rent rent;

  @override
  Widget build(BuildContext context) {
    var parent = context.findAncestorStateOfType<RentedItemListViewState>();
    var date = DateTime.parse(rent.date.toString());
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: RoundedBorder(
        color: Theme.of(context).cardColor,
        height: 56,
        width: double.infinity,
        radius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () => parent!.setState(() {
            RentedBox.groupNum = rent.id;
          }),
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(right: 8, top: 16, bottom: 16, left: 16),
                child: Container(
                  width: 16,
                  height: 16,
                  child: Radio<int>(
                    activeColor: const Color(0xFFDE2B13),
                    value: rent.id,
                    groupValue: RentedBox.groupNum,
                    onChanged: (value) => parent!.setState(() {
                      RentedBox.groupNum = value!;
                    }),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rent.product.category,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 2.5),
                  Text(
                      date.year.toString() +
                          "." +
                          date.month.toString() +
                          "." +
                          date.day.toString() +
                          " 에 대여함",
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontSize: 11, fontWeight: FontWeight.w400))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
