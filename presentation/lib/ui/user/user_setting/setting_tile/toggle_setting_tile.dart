import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/default_toggle.dart';

class ToggleSettingTile extends StatefulWidget {
  final String title;
  final bool value;
  final Function(bool isOn)? onChanged;

  const ToggleSettingTile({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  @override
  State<ToggleSettingTile> createState() => _ToggleSettingTileState();
}

class _ToggleSettingTileState extends State<ToggleSettingTile> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        setState(() {
          isOn = !isOn;
          widget.onChanged?.call(isOn);
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: theme.neutral60,
              ),
            ),
            DefaultToggle(
              value: isOn,
              onChanged: (toggleIsOn) {
                isOn = toggleIsOn;
                widget.onChanged?.call(isOn);
              },
            ),
          ],
        ),
      ),
    );
  }
}
