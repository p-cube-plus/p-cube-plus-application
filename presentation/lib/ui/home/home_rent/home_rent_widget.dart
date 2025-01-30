import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/constants/asset_path.dart' as asset;
import 'package:presentation/ui/home/home_rent/home_rent_viewmodel.dart';
import 'package:presentation/ui/home/home_rent/skeleton_widget/home_rent_skeleton.dart';
import 'package:presentation/ui/product/product_page.dart';
import 'package:presentation/ui/product/user_rent_tab/user_rent_list_item.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:provider/provider.dart';

class HomeRentWidget extends StatelessWidget {
  const HomeRentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeRentViewmodel(),
      child: _HomeRentWidget(),
    );
  }
}

class _HomeRentWidget extends StatelessWidget
    with ViewModel<HomeRentViewmodel> {
  const _HomeRentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "대여한 물품",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.neutral100,
              ),
            ),
            GestureDetector(
              onTap: () => _navigateToProductPage(context),
              child: Row(
                children: [
                  Text(
                    "자세히 보기",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: theme.neutral40,
                    ),
                  ),
                  SizedBox(width: 4),
                  SvgPicture.asset(
                    asset.right,
                    width: 10,
                    height: 10,
                    colorFilter: ColorFilter.mode(
                      theme.neutral40,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        DefaultFutureBuilder(
          fetchData: read(context).fetchUserRentProductList(),
          showOnLoadedWidget: (context, rentList) {
            if (rentList.isEmpty) {
              return Text(
                "대여한 물품이 없습니다.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: theme.neutral60,
                ),
              );
            }

            return Column(
              children: List.generate(
                rentList.length,
                (index) {
                  return UserRentListItem(
                    rentList[index],
                    showRightImage: true,
                  );
                },
              ),
            );
          },
          showOnLoadingWidget: (context) => HomeRentSkeleton(),
        )
      ],
    );
  }

  void _navigateToProductPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductPage(),
      ),
    );
  }
}
