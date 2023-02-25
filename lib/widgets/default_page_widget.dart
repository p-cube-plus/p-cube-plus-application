import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_appbar_widget.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({
    Key? key,
    this.appBarTitle,
    this.appBarSecondTitle,
    this.appBarActions,
    this.appBarHasPrevious,
    this.appBarPadding,
    this.subtitle,
    this.content,
    this.padding,
    this.scrollable = true,
    this.floatingActionButton,
    this.backgroundColor,
    this.appBarTitleColor,
    this.subtitleColor,
    this.previousButtonColor,
  }) : super(key: key);

  final String? appBarTitle;
  final String? appBarSecondTitle;
  final List<Widget>? appBarActions;
  final bool? appBarHasPrevious;
  final EdgeInsetsGeometry? appBarPadding;
  final Widget? content;
  final double? padding;
  final bool scrollable;
  final Widget? floatingActionButton;
  final String? subtitle;
  final Color? backgroundColor;
  final Color? appBarTitleColor;
  final Color? subtitleColor;
  final Color? previousButtonColor;

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle.dark.copyWith(
    //     statusBarColor: Colors.transparent,
    //   ),
    // );

    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: backgroundColor ?? Theme.of(context).backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomAppBar(
                title: appBarTitle,
                secondTitle: appBarSecondTitle,
                subtitle: subtitle,
                actions: appBarActions,
                hasPrevious: appBarHasPrevious,
                previousButtonColor: previousButtonColor,
                appbarTitleColor: appBarTitleColor ??
                    Theme.of(context).textTheme.headline1!.color,
                subtitleColor: subtitleColor,
                padding: appBarPadding,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding ?? 20.0),
                child: scrollable
                    ? SingleChildScrollView(child: content)
                    : content,
              ),
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
