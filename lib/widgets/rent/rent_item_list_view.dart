import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/remote/models/rent_dto.dart';
import 'package:p_cube_plus_application/providers/api_provider/rent_provider.dart';
import 'package:p_cube_plus_application/widgets/common/default_futureBuilder.dart';
import 'package:p_cube_plus_application/widgets/common/default_refreshIndicator.dart';
import 'package:p_cube_plus_application/widgets/page/default_content.dart';
import 'package:provider/provider.dart';

import 'button_page.dart';
import 'rent_box.dart';

class RentItemListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultContent(
      child: ButtonPage(
        names: ["전체", "대여 가능", "대여 중"],
        contents: [RentItemView(), RentItemView(), RentItemView()],
      ),
    );
  }
}

class RentItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rentProvider = context.watch<RentProvider>();

    return DefaultRefreshIndicator(
      refreshFunction: rentProvider.refresh,
      child: DefaultFutureBuilder(
          fetchData: rentProvider.fetch(),
          showFunction: (List<RentDTO> data) => Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                data.length,
                (index) {
                  return RentBox(rent: data[index]);
                },
              ))),
    );
  }
}
