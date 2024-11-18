import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class RightArrowSettingTile extends StatelessWidget {
  const RightArrowSettingTile({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final void Function(BuildContext)? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => onTap?.call(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: theme.neutral100,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.neutral40,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
