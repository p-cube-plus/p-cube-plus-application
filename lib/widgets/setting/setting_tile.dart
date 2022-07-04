import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

enum SettingType {
  None,
  Default,
  Text,
  Switch,
}

abstract class SettingTile extends StatelessWidget {
  final height = 50.0;
  final background = Colors.white70;
  final title;
  tapFunc(context);

  SettingTile({required String this.title});
}

class NewPageTile extends SettingTile {
  NewPageTile({required String title}) : super(title: title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: super.height,
      child: InkWell(
        onTap: () => tapFunc(context),
        child: Container(
          color: super.background,
          child: Row(
            children: [
              const SizedBox(width: 20),
              Text(title),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  tapFunc(context) {
    // TODO: implement tapFunc
    throw UnimplementedError();
  }
}
