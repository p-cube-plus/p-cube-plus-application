import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/setting/setting_tile.dart';
import 'package:p_cube_plus_application/providers/setting_provider.dart';
import 'package:provider/provider.dart';

class SwitchTile extends SettingTile {
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
        child: Container(
          padding: super.horizontalPadding,
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
              Container(
                width: 32,
                height: 16,
                child: FittedBox(
                  child: CupertinoSwitch(
                    activeColor: Colors.red,
                    //activeTrackColor: Colors.red.withOpacity(0.4),
                    //inactiveThumbColor: Colors.blue,
                    //inactiveTrackColor: Colors.blue.withOpacity(0.4),
                    //splashRadius: 30, // 클릭 시 색 크기
                    value: _value,
                    onChanged: (value) {
                      settingProvider.changeState(type);
                      _value = value;
                      settingProvider.toggle(_value);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
