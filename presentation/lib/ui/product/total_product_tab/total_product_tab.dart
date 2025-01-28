import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/product/value_objects/product.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/product/product_detail/product_detail_page.dart';
import 'package:presentation/ui/product/product_view_model.dart';
import 'package:presentation/ui/product/skeleton_widget/total_product_tab_skeleton.dart';
import 'package:presentation/widgets/rounded_border.dart';

class TotalProductTab extends StatelessWidget with ViewModel<ProductViewModel> {
  const TotalProductTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              watchWidget(
                (viewModel) => viewModel.filterType == ProductFilterType.total,
                (context, isSelected) {
                  return RoundedBorder(
                    onTap: () =>
                        read(context).changeFilterType(ProductFilterType.total),
                    color: isSelected ? theme.primary80 : theme.content,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Text(
                      "전체",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : theme.neutral40,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(width: 8),
              watchWidget(
                (viewModel) =>
                    viewModel.filterType == ProductFilterType.rentable,
                (context, isSelected) {
                  return RoundedBorder(
                    onTap: () => read(context)
                        .changeFilterType(ProductFilterType.rentable),
                    color: isSelected ? theme.primary80 : theme.content,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Text(
                      "대여 가능",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : theme.neutral40,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(width: 8),
              watchWidget(
                (viewModel) => viewModel.filterType == ProductFilterType.rented,
                (context, isSelected) {
                  return RoundedBorder(
                    onTap: () => read(context)
                        .changeFilterType(ProductFilterType.rented),
                    color: isSelected ? theme.primary80 : theme.content,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Text(
                      "대여 중",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : theme.neutral40,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 12),
          Expanded(
            child: watchWidget((viewModel) => viewModel.currentTargetList,
                (context, productList) {
              if (productList == null) {
                return TotalProductTabSkeleton();
              }

              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final data = productList[index];
                  if (data is RentedProduct) {
                    return RoundedBorder(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 8),
                      onTap: () => _navigateToProductDetailPage(context),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                data.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: theme.neutral100,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  data.typeName,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: theme.neutral40,
                                  ),
                                ),
                              ),
                              Text(
                                data.location,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: theme.neutral40,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: theme.neutral10,
                          ),
                          Row(
                            children: [
                              Text(
                                data.rentUserName,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: theme.neutral100,
                                ),
                              ),
                              SizedBox(width: 8),
                              if (data.isRentExpired)
                                RoundedBorder(
                                  color: theme.primary10,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Text(
                                    "대여 만료",
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                      color: theme.primary60,
                                    ),
                                  ),
                                ),
                              Expanded(
                                child: Text(
                                  "${data.rentStartDate.format("yyyy.M.d")} ~ ${data.rentEndDate.format("yyyy.M.d")}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: data.isRentExpired
                                        ? theme.primary60
                                        : theme.neutral40,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return RoundedBorder(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 8),
                      onTap: () => _navigateToProductDetailPage(context),
                      child: Row(
                        children: [
                          Text(
                            data.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: theme.neutral100,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              data.typeName,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: theme.neutral40,
                              ),
                            ),
                          ),
                          Text(
                            data.location,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: theme.neutral40,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            }),
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
