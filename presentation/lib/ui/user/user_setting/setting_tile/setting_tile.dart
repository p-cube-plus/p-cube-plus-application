import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        width: double.infinity,
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: theme.neutral100,
          ),
        ),
      ),
    );
  }
}
