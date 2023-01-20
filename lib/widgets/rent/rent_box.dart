import 'package:flutter/material.dart';

import '../../models/rent.dart';
import '../rounded_border_widget.dart';
import 'rent_item_list_view.dart';

class RentBox extends StatelessWidget {
  const RentBox({
    Key? key,
    required this.rent,
    required this.isActive,
  }) : super(key: key);

  static int groupNum = -1;
  final Rent rent;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    var parent = context.findAncestorStateOfType<RentItemListViewState>();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: RoundedBorder(
        color: isActive
            ? Theme.of(context).cardColor
            : Theme.of(context).dialogBackgroundColor,
        height: 48,
        width: double.infinity,
        radius: 10,
        child: InkWell(
          onTap: () => parent!.setState(() {
            RentBox.groupNum = rent.id;
          }),
          borderRadius: BorderRadius.circular(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: 8, top: 16, bottom: 16, left: 16),
                    child: Container(
                      width: 16,
                      height: 16,
                      child: isActive
                          ? Radio<int>(
                              activeColor: const Color(0xFFDE2B13),
                              value: rent.id,
                              groupValue: RentBox.groupNum,
                              onChanged: (value) => parent!.setState(() {
                                RentBox.groupNum = value!;
                              }),
                            )
                          : SizedBox(width: 0),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(rent.product.name,
                      style: isActive
                          ? Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w500)
                          : Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w500))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(rent.product.category,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w700)),
                      Text(rent.product.location,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400)),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
