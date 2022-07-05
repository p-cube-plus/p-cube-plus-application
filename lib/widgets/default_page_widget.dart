import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_appbar_widget.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({
    Key? key,
    required this.appBarTitle,
    this.appBarActions,
    this.appBarHasPrevious,
    this.content,
  }) : super(key: key);

  final String appBarTitle;
  final List<Widget>? appBarActions;
  final bool? appBarHasPrevious;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Theme.of(context).backgroundColor,
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomAppBar(
              title: appBarTitle,
              actions: appBarActions,
              hasPrevious: appBarHasPrevious,
            ),
            Expanded(child: SingleChildScrollView(child: content)),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
