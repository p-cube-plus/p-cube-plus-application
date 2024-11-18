import 'package:flutter/material.dart';
import 'package:presentation/app_view_model.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_setting/bottom_sheet/theme_setting_bottom_sheet.dart';
import 'package:presentation/widgets/default_bottomsheet.dart';

class ThemeSettingTile extends StatefulWidget with ViewModel<AppViewModel> {
  const ThemeSettingTile({super.key});

  @override
  State<ThemeSettingTile> createState() => _ThemeSettingTileState();
}

class _ThemeSettingTileState extends State<ThemeSettingTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => _showThemeSettingBottomSheet(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "테마 설정",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: theme.neutral100,
              ),
            ),
            Expanded(
              child: widget
                  .watchWidget((viewModel) => viewModel.currentThemeMode,
                      (context, themeMode) {
                final themeString = switch (themeMode) {
                  ThemeMode.system => "시스템 모드",
                  ThemeMode.light => "라이트 모드",
                  ThemeMode.dark => "다크 모드",
                };

                return Text(
                  themeString,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: theme.neutral40,
                  ),
                );
              }),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.neutral40,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeSettingBottomSheet() {
    BottomSheetBuilder().build(
      context,
      ThemeSettingBottomSheet(),
    );
  }
}
