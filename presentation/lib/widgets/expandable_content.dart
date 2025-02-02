import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class ExpandableContent extends StatefulWidget {
  const ExpandableContent({
    super.key,
    required this.categoryText,
    required this.expandedWidget,
  });

  final String categoryText;
  final Widget expandedWidget;

  @override
  State<ExpandableContent> createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (isExpanded) {
      return RoundedBorder(
        onTap: () => setState(() => isExpanded = false),
        padding: EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.categoryText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: theme.neutral60,
                  ),
                ),
                SvgPicture.asset(
                  asset.up,
                  colorFilter: ColorFilter.mode(
                    theme.neutral40,
                    BlendMode.srcIn,
                  ),
                  width: 16,
                  height: 16,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                thickness: 1,
                color: theme.neutral10,
              ),
            ),
            widget.expandedWidget,
          ],
        ),
      );
    }

    return RoundedBorder(
      onTap: () => setState(() => isExpanded = true),
      padding: EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.categoryText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: theme.neutral60,
            ),
          ),
          SvgPicture.asset(
            asset.down,
            colorFilter: ColorFilter.mode(
              theme.neutral40,
              BlendMode.srcIn,
            ),
            width: 16,
            height: 16,
          ),
        ],
      ),
    );
  }
}
