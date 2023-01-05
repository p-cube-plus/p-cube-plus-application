import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_appbar_widget.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({
    Key? key,
    this.appBarTitle,
    this.appBarActions,
    this.appBarHasPrevious,
    this.subtitle,
    this.content,
    this.padding,
    this.scrollable = true,
    this.floatingActionButton,
  }) : super(key: key);

  final String? appBarTitle;
  final List<Widget>? appBarActions;
  final bool? appBarHasPrevious;
  final Widget? content;
  final double? padding;
  final bool scrollable;
  final Widget? floatingActionButton;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(
    //  SystemUiOverlayStyle.dark.copyWith(
    //    statusBarColor: Theme.of(context).backgroundColor,
    //  ),
    //);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomAppBar(
              title: appBarTitle,
              subtitle: subtitle,
              actions: appBarActions,
              hasPrevious: appBarHasPrevious,
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding ?? 20.0),
            child: scrollable ? SingleChildScrollView(child: content) : content,
          )),
        ],
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: floatingActionButton,
    );
  }
}
