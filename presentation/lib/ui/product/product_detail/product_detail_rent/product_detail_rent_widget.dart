import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/product/value_objects/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/rounded_border.dart';

class ProductDetailRentWidget extends StatelessWidget {
  const ProductDetailRentWidget(this.data, {super.key});

  final ProductDetail data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "대여 기간",
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
            children: [
              Row(
                children: [
                  Text(
                    "반납까지 ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: theme.neutral100,
                    ),
                  ),
                  Text(
                    "${data.dDay}일",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: theme.primary80,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "대여한 날짜",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral100,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    data.rentStartDate.format("yyyy.MM.dd"),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral100,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "반납 마감일",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral100,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    data.rentEndDate.format("yyyy.MM.dd"),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral100,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "대여자",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral100,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    data.rentUserName!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral100,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 32),
      ],
    );
  }
}
