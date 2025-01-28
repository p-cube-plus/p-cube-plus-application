import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/product/product_search/product_search_page.dart';
import 'package:presentation/ui/product/product_view_model.dart';
import 'package:presentation/ui/product/total_product_tab/total_product_tab.dart';
import 'package:presentation/ui/product/user_rent_tab/user_rent_tab.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/constants/asset_path.dart' as asset;
import 'package:presentation/widgets/default_tabbar.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel(),
      child: _ProductPage(),
    );
  }
}

class _ProductPage extends StatelessWidget with ViewModel<ProductViewModel> {
  const _ProductPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      title: "물품",
      appbar: DefaultAppBar(),
      action: GestureDetector(
        onTap: () => _navigateToProductSearchPage(context),
        child: SvgPicture.asset(
          asset.search,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            theme.neutral100,
            BlendMode.srcIn,
          ),
        ),
      ),
      content: DefaultTabBar(
          overLayColor: Colors.transparent,
          padding: EdgeInsets.only(left: 16, bottom: 8),
          tabLabelPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          indicatorInsets: EdgeInsets.symmetric(horizontal: 4),
          tabs: [
            DefaultTab(tabName: "물품 현황", page: TotalProductTab()),
            DefaultTab(tabName: "내가 대여한", page: UserRentTab()),
          ]),
    );
  }

  void _navigateToProductSearchPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductSearchPage(read(context).totalList),
      ),
    );
  }
}
