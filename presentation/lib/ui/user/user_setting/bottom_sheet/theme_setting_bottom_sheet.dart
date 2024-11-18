import 'package:domain/app_configuration/value_objects/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/app_view_model.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/default_radio_group_tile.dart';

class ThemeSettingBottomSheet extends StatelessWidget
    with SharedViewModel<AppViewModel> {
  const ThemeSettingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "테마 설정",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).neutral100,
            ),
          ),
        ),
        SizedBox(height: 16),
        DefaultRadioGroupTile<ThemeType>(
          onTap: (data) => sharedRead(context).updateThemeType(data),
          radioDataList: [
            RadioData(title: "시스템 설정 사용", data: ThemeType.system),
            RadioData(title: "라이트 모드", data: ThemeType.light),
            RadioData(title: "다크 모드", data: ThemeType.dark),
          ],
          initializeIndex: sharedRead(context).currentThemeMode.index,
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
