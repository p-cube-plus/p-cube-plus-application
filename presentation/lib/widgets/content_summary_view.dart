import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class ContentSummaryView extends StatelessWidget {
  const ContentSummaryView({
    super.key,
    required this.title,
    this.titleFontSize,
    this.descript,
    required this.onTapSeeMoreDetails,
    this.children,
  });

  final String title;
  final double? titleFontSize;
  final Widget? descript;
  final List<Widget>? children;
  final Function()? onTapSeeMoreDetails;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> barContents = <Widget>[];
    if (descript != null) barContents.insert(1, Expanded(child: descript!));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: theme.neutral100,
                fontSize: titleFontSize ?? 14.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: onTapSeeMoreDetails,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "자세히 보기",
                    style: TextStyle(
                      color: theme.neutral40,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: theme.neutral40,
                    size: 20.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
