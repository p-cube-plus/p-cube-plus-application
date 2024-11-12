import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({
    super.key,
    this.centerTitle,
    this.leftTitle,
    this.leftTitleState,
    this.hasPrevious = true,
    this.contentColor,
    this.backgroundColor,
    this.bottomPadding = 24.0,
  });
  final String? centerTitle;
  final String? leftTitle;
  final Widget? leftTitleState;
  final bool hasPrevious;
  final Color? contentColor;
  final Color? backgroundColor;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final topPadding = (leftTitleState == null) ? 19.0 : 34.0;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.0,
          color: backgroundColor ?? theme.background,
        ),
        color: backgroundColor ?? theme.background,
      ),
      padding: EdgeInsets.only(
          left: 24.0,
          right: 24.0,
          top: statusBarHeight + topPadding,
          bottom: bottomPadding),
      child: Row(
        mainAxisAlignment: centerTitle != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          if (hasPrevious)
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 20.0,
                color: contentColor ?? theme.neutral100,
              ),
            )
          else
            const SizedBox(),
          if (centerTitle != null)
            Text(
              centerTitle!,
              style: theme.textTheme.displayLarge!.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: contentColor ?? theme.neutral100,
              ),
            ),
          if (leftTitle != null)
            Row(
              children: [
                Text(
                  leftTitle!,
                  style: theme.textTheme.displayLarge!.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: contentColor ?? theme.neutral100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: leftTitleState,
                )
              ],
            ),
          SizedBox(width: centerTitle != null ? 20.0 : 0.0)
        ],
      ),
    );
  }
}
