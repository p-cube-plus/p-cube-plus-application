import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/setting/setting_tile.dart';

class NewPageTile extends SettingTile {
  final newPage;
  NewPageTile({required String title, required Widget this.newPage})
      : super(title: title);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => tapFunc(context),
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
    );
  }

  tapFunc(context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => newPage,
      ),
    );
  }
}
