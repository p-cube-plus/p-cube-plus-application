import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

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
            SvgPicture.asset(
              asset.right,
              colorFilter: ColorFilter.mode(
                theme.neutral40,
                BlendMode.srcIn,
              ),
              width: 12,
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
