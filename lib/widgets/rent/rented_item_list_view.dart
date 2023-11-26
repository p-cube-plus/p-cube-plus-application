import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/api_provider/rent_provider.dart';
import 'package:p_cube_plus_application/widgets/common/default_futureBuilder.dart';
import 'package:p_cube_plus_application/widgets/common/default_refreshIndicator.dart';
import 'package:p_cube_plus_application/widgets/rent/rent_button.dart';
import 'package:p_cube_plus_application/widgets/rent/rented_box.dart';
import 'package:provider/provider.dart';

import '../../models/rent.dart';

class RentedItemListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rentProvider = context.watch<RentProvider>();

    return DefaultRefreshIndicator(
      refreshFunction: rentProvider.refresh(),
      child: DefaultFutureBuilder(
          fetchData: rentProvider.fetch(),
          showFunction: (List<Rent> data) => Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RentedBox(rent: data[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 24.0),
                    child:
                        RentButton(text: "스캔하기", isActive: true, isRent: true),
                  )
                ],
              )),
    );
  }
}
