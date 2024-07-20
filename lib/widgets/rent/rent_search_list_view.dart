import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/api_provider/rent_provider.dart';
import 'package:provider/provider.dart';
import '../../remote_f/models/rent_dto.dart';
import '../../screens/rent/rent_detail_page.dart';
import 'rent_box.dart';

class RentSearchListView extends StatelessWidget {
  const RentSearchListView({required this.productName});
  final String productName;

  @override
  Widget build(BuildContext context) {
    final rentProvider = context.read<RentProvider>();
    return FutureBuilder<List<RentDTO>>(
      future: rentProvider.searchRentList(productName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length == 0)
            return Text(
              "검색 결과가 없어요 ㅠㅠ",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
            );
          return Column(
            children: List.generate(snapshot.data!.length, (index) {
              return GestureDetector(
                onDoubleTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RentDetailPage(
                      rent: snapshot.data![index],
                    ),
                  ),
                ),
                child: RentBox(rent: snapshot.data![index]),
              );
            }),
          );
        } else if (snapshot.hasError) {
          return productName == "" ? Container() : Text("이상해요");
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
