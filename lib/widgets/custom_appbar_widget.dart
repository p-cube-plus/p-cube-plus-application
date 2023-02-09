import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.secondTitle,
    this.subtitle,
    this.height,
    this.actions,
    this.hasPrevious,
    this.padding,
    this.appbarTitleColor,
    this.previousButtonColor,
    this.subtitleColor,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;
  final String? title;
  final String? secondTitle;
  final String? subtitle;
  final double? height;
  final List<Widget>? actions;
  final bool? hasPrevious;

  final Color? appbarTitleColor;
  final Color? subtitleColor;
  final Color? previousButtonColor;

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = <Widget>[];
    if (title != null)
      _widgets.insert(
        0,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        color: appbarTitleColor,
                      ),
                ),
                if (secondTitle != null)
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      secondTitle!,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: appbarTitleColor,
                              ),
                    ),
                  )
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions ?? [],
              ),
            ),
          ],
        ),
      );
    if (hasPrevious ?? false)
      _widgets.insert(
        0,
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  subtitle ?? "",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: subtitleColor,
                      ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.0,
                  color: previousButtonColor,
                ),
              ),
            ],
          ),
        ),
      );

    return Padding(
      padding: padding ?? EdgeInsets.only(top: 40.0, bottom: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
        ]..add(
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _widgets,
              ),
            ),
          ),
      ),
    );
  }
}
