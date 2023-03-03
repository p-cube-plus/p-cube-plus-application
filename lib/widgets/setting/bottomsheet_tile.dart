import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/setting/Tsetting_tile.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class BottomSheetTile extends TSettingTile {
  final String bottomTitle;
  final List<Widget> bottomWidgets;

  BottomSheetTile(
      {required String title,
      required this.bottomTitle,
      required this.bottomWidgets})
      : super(title: title);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      child: InkWell(
        onTap: () => showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            builder: (context) => Column(
                  children: _getChildren(context),
                )),
        child: Container(
          padding: super.allPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: getTextStyle(context),
              ),
              Row(
                children: [
                  Text(
                    (themeProvider.type == ThemeMode.system)
                        ? "시스템 설정"
                        : ((themeProvider.type == ThemeMode.light)
                            ? "라이트 모드"
                            : "다크 모드"),
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(fontWeight: FontWeight.w400, fontSize: 11),
                  ),
                  SizedBox(width: 10.5),
                  Icon(Icons.arrow_forward_ios, size: defaultFontSize),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getChildren(context) {
    List<Widget> result = <Widget>[];

    result.add(Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Text(bottomTitle,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                )),
      ),
    ));
    result.add(Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: bottomWidgets,
        ),
      ),
    ));
    return result;
  }
}
