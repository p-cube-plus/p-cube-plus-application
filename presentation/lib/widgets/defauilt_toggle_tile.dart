import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/default_toggle.dart';
import 'package:presentation/widgets/rounded_border.dart';

class DefaultToggleTile extends StatefulWidget {
  final String title;
  final bool value;
  final Color? background;
  final Function(bool isOn)? onChanged;
  final EdgeInsets? padding;
  final bool hasShadow;

  const DefaultToggleTile({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
    this.background,
    this.padding,
    this.hasShadow = true,
  });

  @override
  State<DefaultToggleTile> createState() => _DefaultToggleTileState();
}

class _DefaultToggleTileState extends State<DefaultToggleTile> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RoundedBorder(
      onTap: () {
        setState(() {
          isOn = !isOn;
          widget.onChanged?.call(isOn);
        });
      },
      hasShadow: widget.hasShadow,
      color: widget.background,
      padding:
          widget.padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      radius: 10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.neutral80,
            ),
          ),
          DefaultToggle(
            value: isOn,
            onChanged: (value) {
              isOn = value;
              widget.onChanged?.call(isOn);
            },
          ),
        ],
      ),
    );
  }
}
