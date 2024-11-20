import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class RestrictedDatePicker extends StatelessWidget {
  const RestrictedDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("날짜 선택하기"),
        SizedBox(height: 24),
        Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.chevron_left,
                color: theme.neutral40,
                size: 24,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
