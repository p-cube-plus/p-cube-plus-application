import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/setting/Tsetting_tile.dart';

class SubTextTile extends TSettingTile {
  SubTextTile({required String title}) : super(title: title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: super.allPadding,
      child: Text(
        title,
        style: getTextStyle(context, isTitle: true),
      ),
    );
  }
}
