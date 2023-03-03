import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/setting/Tsetting_tile.dart';

class MainTitleTile extends TSettingTile {
  MainTitleTile({required String title}) : super(title: title);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: getTextStyle(context),
              ),
            ],
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    );
  }
}
