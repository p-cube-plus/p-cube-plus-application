import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/product/product_view_model.dart';
import 'package:presentation/ui/product/skeleton_widget/user_rent_tab_skeleton.dart';
import 'package:presentation/ui/product/user_rent_tab/user_rent_list_item.dart';
import 'package:presentation/widgets/default_future_builder.dart';

class UserRentTab extends StatefulWidget {
  const UserRentTab({super.key});

  @override
  State<UserRentTab> createState() => _UserRentTabState();
}

class _UserRentTabState extends State<UserRentTab>
    with ViewModel<ProductViewModel>, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: DefaultFutureBuilder(
        fetchData: read(context).fetchUserRentProductList(),
        showOnLoadedWidget: (context, rentProductList) {
          return ListView.builder(
            padding: EdgeInsets.only(bottom: 72),
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
        showOnLoadingWidget: (context) => UserRentTabSkeleton(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
