import 'package:domain/product/value_objects/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/product/product_detail/product_detail_page.dart';
import 'package:presentation/ui/product/product_search/product_search_viewmodel.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_text_field.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:provider/provider.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class ProductSearchPage extends StatelessWidget {
  final List<Product> totalList;

  const ProductSearchPage(this.totalList, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductSearchViewModel(totalList),
      child: _ProductSearchPage(),
    );
  }
}

class _ProductSearchPage extends StatefulWidget {
  const _ProductSearchPage();

  @override
  State<_ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<_ProductSearchPage>
    with ViewModel<ProductSearchViewModel> {
  late TextEditingController _textInputController;
  late ScrollController _scrollController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();

    _textInputController = TextEditingController()
      ..addListener(() {
        read(context).setSearchText(_textInputController.text);
      });

    _scrollController = ScrollController()
      ..addListener(() {
        _focusNode.unfocus();
      });
  }

  @override
  void dispose() {
    _textInputController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(),
      title: "물품검색",
      content: Column(
        children: [
          RoundedBorder(
            height: 32,
            radius: 50,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.only(left: 8, right: 12),
            child: Row(
              children: [
                Expanded(
                  child: DefaultTextField(
                    focusNode: _focusNode,
                    autofocus: true,
                    maxLength: 30,
                    inputController: _textInputController,
                    hintText: "물품명을 검색해주세요.",
                  ),
                ),
                SvgPicture.asset(
                  asset.search,
                  width: 12,
                  height: 12,
                  colorFilter: ColorFilter.mode(
                    theme.neutral40,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: watchWidget(
              (viewModel) => viewModel.resultList,
              (context, resultList) {
                return GestureDetector(
                  onTap: () => _focusNode.unfocus(),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: resultList.length,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      final data = resultList[index];
                      return RoundedBorder(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        margin: EdgeInsets.only(bottom: 8, left: 20, right: 20),
                        onTap: () => _navigateToProductDetailPage(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.name,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: theme.neutral100,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  data.typeName,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: theme.neutral40,
                                  ),
                                ),
                                Text(
                                  data.location,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: theme.neutral40,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToProductDetailPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductDetailPage(),
      ),
    );
  }
}
