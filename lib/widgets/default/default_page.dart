import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p_cube_plus_application/widgets/default/default_tabbar.dart';

import 'default_appbar.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({
    this.appbar,
    this.title,
    this.subtitle,
    this.content,
    this.action,
    this.decorate,
    this.floatingActionButton,
    this.textColor,
    this.contentColor,
    this.backgroundColor,
    this.bottomPadding = 0.0,
  });

  final DefaultAppBar? appbar;
  final String? title;
  final String? subtitle;
  final Widget? content;
  final Widget? action;
  final Widget? decorate;
  final Widget? floatingActionButton;
  final Color? textColor;
  final Color? contentColor;
  final Color? backgroundColor;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final topPadding = (appbar != null) ? 19.0 : statusBarHeight + 34.0;
    return Scaffold(
      backgroundColor: contentColor ?? theme.backgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          appbar ?? SizedBox(),
          Container(
            color: backgroundColor ?? contentColor ?? theme.backgroundColor,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: topPadding,
                  bottom: bottomPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title != null)
                        Text(title!,
                            style: theme.textTheme.headline1!.copyWith(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                                color: textColor ??
                                    theme.textTheme.headline1!.color)),
                      if (subtitle != null)
                        Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text(subtitle!,
                              style: theme.textTheme.headline1!.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  color: textColor ??
                                      theme.textTheme.headline1!.color)),
                        ),
                    ],
                  ),
                  action ?? SizedBox(),
                ],
              ),
            ),
          ),
          decorate ?? SizedBox(),
          Expanded(child: content ?? SizedBox())
        ],
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: floatingActionButton,
    );
  }
}
