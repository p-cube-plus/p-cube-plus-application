import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/setting/setting_tile.dart';

class BottomSheetTile extends SettingTile {
  final String bottomTitle;
  final List<Widget> bottomWidgets;

  BottomSheetTile(
      {required String title,
      required this.bottomTitle,
      required this.bottomWidgets})
      : super(title: title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            builder: (context) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                  child: Column(
                    children: _getChildren(context),
                  ),
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
              Icon(Icons.arrow_forward_ios, size: defaultFontSize),
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
        padding: EdgeInsets.only(bottom: 32),
        child: Text(bottomTitle,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                )),
      ),
    ));
    result.addAll(bottomWidgets);
    return result;
  }
}
