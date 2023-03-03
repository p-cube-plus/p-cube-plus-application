import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:p_cube_plus_application/widgets/setting/Tsetting_tile.dart';
import 'package:p_cube_plus_application/providers/setting_provider.dart';
import 'package:provider/provider.dart';

class SwitchTile extends TSettingTile {
  final type;
  SwitchTile({required String title, required SettingType this.type})
      : super(title: title);

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);
    settingProvider.changeState(type);
    bool _value = settingProvider.isOn;
    print(_value);
    return Container(
      //padding: super.verticalPadding,
      child: InkWell(
        onTap: () {
          settingProvider.changeState(type);
          _value = !_value;
          settingProvider.toggle(_value);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: super.verticalPadding,
              child: Text(super.title, style: getTextStyle(context)),
            ),

            // Switch.adaptive
            // CupertinoSwitch
            // Switch
            FlutterSwitch(
              width: 32,
              height: 16,
              activeColor: Color(0xFFDE2B13),
              value: _value,
              toggleSize: 12,
              borderRadius: 50,
              padding: 2,
              onToggle: (value) {
                settingProvider.changeState(type);
                _value = value;
                settingProvider.toggle(_value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
