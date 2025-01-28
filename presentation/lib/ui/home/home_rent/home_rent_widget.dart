import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/constants/asset_path.dart' as asset;
import 'package:presentation/ui/home/home_rent/home_rent_viewmodel.dart';
import 'package:presentation/ui/home/home_rent/skeleton_widget/home_rent_skeleton.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/rounded_border.dart';
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
              onTap: () {},
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
        SizedBox(height: 8),
        DefaultFutureBuilder(
          fetchData: read(context).fetchUserRentProductList(),
          showOnLoadedWidget: (context, rentList) {
            return Column(
              children: List.generate(rentList.length, (index) {
                final rentData = rentList[index];
                return RoundedBorder(
                  margin: EdgeInsets.only(bottom: 8),
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rentData.name,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: theme.neutral100,
                            ),
                          ),
                          Text(
                            "${rentData.rentStartDate.format("yyyy.MM.dd")} 에 대여함",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: theme.neutral40,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Row(
                          children: [
                            Text(
                              rentData.dDay < 0
                                  ? "${-rentData.dDay}일 초과"
                                  : (rentData.dDay == 0
                                      ? "D-DAY"
                                      : "D-${rentData.dDay}"),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: rentData.dDay <= 7
                                    ? theme.primary80
                                    : theme.neutral100,
                              ),
                            ),
                            SizedBox(width: 8),
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
                      ),
                    ],
                  ),
                );
              }),
            );
          },
          showOnLoadingWidget: (context) => HomeRentSkeleton(),
        )
      ],
    );
  }
}
