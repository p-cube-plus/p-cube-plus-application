import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class StatusCheck extends StatelessWidget {
  final bool isChecked;
  final double size;
  const StatusCheck({super.key, required this.isChecked, required this.size});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (isChecked) {
      return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: theme.primary80,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_rounded,
          color: Colors.white,
          size: size * 0.7,
        ),
      );
    } else {
      return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: theme.neutral20,
            width: 1.5,
          ),
        ),
        child: Icon(
          Icons.check_rounded,
          color: theme.neutral20,
          size: size * 0.7,
        ),
      );
    }
  }
}
