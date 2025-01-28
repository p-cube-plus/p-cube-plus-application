import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/product/value_objects/user_rent_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class UserRentListItem extends StatelessWidget {
  final UserRentProduct userRentProduct;
  final bool showRightImage;

  const UserRentListItem(
    this.userRentProduct, {
    required this.showRightImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                userRentProduct.name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: theme.neutral100,
                ),
              ),
              Text(
                "${userRentProduct.rentStartDate.format("yyyy.MM.dd")} 에 대여함",
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
                  userRentProduct.dDay < 0
                      ? "${-userRentProduct.dDay}일 초과"
                      : (userRentProduct.dDay == 0
                          ? "D-DAY"
                          : "D-${userRentProduct.dDay}"),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: userRentProduct.dDay <= 7
                        ? theme.primary80
                        : theme.neutral100,
                  ),
                ),
                SizedBox(width: 8),
                if (showRightImage)
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
  }
}
