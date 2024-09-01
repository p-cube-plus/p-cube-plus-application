import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/rent/rented_detail.dart';

import '../../remote_f/models/rent_dto.dart';
import '../common/rounded_border.dart';

class RentedBox extends StatelessWidget {
  const RentedBox({
    Key? key,
    required this.rent,
  }) : super(key: key);

  final RentDTO rent;

  @override
  Widget build(BuildContext context) {
    var date = rent.rentDay;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: RoundedBorder(
        hasShadow: true,
        color: Theme.of(context).cardColor,
        height: 56,
        width: double.infinity,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RentedDetail(rent: rent),
            ),
          ),
          borderRadius: BorderRadius.circular(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rent.product.category,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
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
                            .displaySmall!
                            .copyWith(
                                fontSize: 11, fontWeight: FontWeight.w400))
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text("D-" + rent.dDay.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w700)))
            ],
          ),
        ),
      ),
    );
  }
}
