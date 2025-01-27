import 'package:domain/common/extensions/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/rounded_border.dart';

class FeeHistoryTotalWidget extends StatelessWidget {
  const FeeHistoryTotalWidget(this.totalAmount, {super.key});

  final int totalAmount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RoundedBorder(
      margin: EdgeInsets.only(top: 24, bottom: 36),
      padding: EdgeInsets.only(top: 32, right: 24, left: 24, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "${totalAmount.toCommaSeparated()}원",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: theme.neutral100,
              ),
            ),
          ),
          SizedBox(height: 32),
          Divider(
            color: theme.neutral10,
            height: 0,
          ),
          SizedBox(height: 16),
          Text(
            "회비계좌",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: theme.neutral40,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () => _copyAccount("카카오뱅크", "1234-5678-90 정성희"),
            child: Row(
              children: [
                Text(
                  "카카오뱅크",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: theme.neutral80,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "1234-5678-90 정성희",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: theme.neutral100,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.content_copy_rounded,
                  color: theme.neutral40,
                  size: 16,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _copyAccount(String accountBank, String accountNumber) {
    Clipboard.setData(ClipboardData(text: "$accountBank $accountNumber"));
  }
}
