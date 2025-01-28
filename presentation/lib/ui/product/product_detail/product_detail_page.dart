import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/product/barcode_reader/floating_barcode_button.dart';
import 'package:presentation/ui/product/product_detail/product_detail_rent/product_detail_rent_widget.dart';
import 'package:presentation/ui/product/product_detail/product_detail_viewmodel.dart';
import 'package:presentation/ui/product/skeleton_widget/product_detail_skeleton.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductDetailViewModel(),
      child: _ProductDetailPage(),
    );
  }
}

class _ProductDetailPage extends StatelessWidget
    with ViewModel<ProductDetailViewModel> {
  const _ProductDetailPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: "물품 세부정보",
      ),
      floatingActionButton: FloatingBarcodeButton(),
      content: DefaultContent(
        child: DefaultFutureBuilder(
          fetchData: read(context).fetchProductDetail(),
          showOnLoadedWidget: (context, data) {
            final keyList = data.detailInfoMap.keys.toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (data.rentUserName != null) ProductDetailRentWidget(data),
                Column(
                  children: List.generate(
                    keyList.length,
                    (index) {
                      final category = keyList[index];
                      final detailInfo = data.detailInfoMap[category]!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: theme.neutral40,
                            ),
                          ),
                          SizedBox(height: 8),
                          RoundedBorder(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children:
                                  List.generate(detailInfo.length, (index) {
                                final detailKey = detailInfo[index].$1;
                                final detailValue = detailInfo[index].$2;
                                final bottomPadding =
                                    (index + 1 == detailInfo.length)
                                        ? 0.0
                                        : 8.0;
                                return Padding(
                                  padding:
                                      EdgeInsets.only(bottom: bottomPadding),
                                  child: Row(
                                    children: [
                                      Text(
                                        detailKey,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: theme.neutral100,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        detailValue,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: theme.neutral100,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                          if (index + 1 != keyList.length) SizedBox(height: 36)
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 72),
              ],
            );
          },
          showOnLoadingWidget: (context) => ProductDetailSkeleton(),
        ),
      ),
    );
  }
}
