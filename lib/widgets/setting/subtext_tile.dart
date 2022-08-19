import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/setting/setting_tile.dart';

class SubTextTile extends SettingTile {
  SubTextTile({required String title}) : super(title: title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: super.allPadding,
      child: Text(
        title,
        style: getTextStyle(context),
      ),
    );
  }
}
