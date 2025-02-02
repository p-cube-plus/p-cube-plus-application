import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class VersionSettingTile extends StatelessWidget {
  const VersionSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "버전",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: theme.neutral100,
            ),
          ),
          Text(
            "v1.0.0",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: theme.neutral60,
            ),
          ),
        ],
      ),
    );
  }
}
