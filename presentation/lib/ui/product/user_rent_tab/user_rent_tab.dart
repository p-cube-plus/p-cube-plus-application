import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/product/product_view_model.dart';
import 'package:presentation/ui/product/user_rent_tab/user_rent_list_item.dart';
import 'package:presentation/widgets/default_future_builder.dart';

class UserRentTab extends StatelessWidget with ViewModel<ProductViewModel> {
  const UserRentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: DefaultFutureBuilder(
        fetchData: read(context).fetchUserRentProductList(),
        showOnLoadedWidget: (context, rentProductList) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: rentProductList.length,
            itemBuilder: (context, index) {
              final data = rentProductList[index];
              return UserRentListItem(
                data,
                showRightImage: false,
              );
            },
          );
        },
      ),
    );
  }
}
