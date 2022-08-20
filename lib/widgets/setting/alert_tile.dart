import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/setting/setting_tile.dart';

class AlertTile extends SettingTile {
  final alertWidget;
  final hasIcon;
  AlertTile(
      {required String title,
      required Widget this.alertWidget,
      required bool this.hasIcon})
      : super(title: title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          showDialog(context: context, builder: (context) => alertWidget);
        },
        child: Container(
          child: Padding(
            padding: super.allPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _getChildren(context),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getChildren(context) {
    final result = <Widget>[];
    result.add(Text(super.title, style: getTextStyle(context)));
    if (hasIcon) {
      result.add(Icon(Icons.arrow_forward_ios, size: defaultFontSize));
    }
    return result;
  }
}
