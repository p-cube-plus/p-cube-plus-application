import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/constants/asset_path.dart' as asset;
import 'package:presentation/widgets/rounded_border.dart';

class HomeRentWidget extends StatelessWidget {
  const HomeRentWidget({super.key});

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
        Column(
          children: List.generate(3, (index) {
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
                        "도서",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: theme.neutral100,
                        ),
                      ),
                      Text(
                        "2022.08.10 에 대여함",
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
                          "D-2",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: theme.primary80,
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
        )
      ],
    );
  }
}
