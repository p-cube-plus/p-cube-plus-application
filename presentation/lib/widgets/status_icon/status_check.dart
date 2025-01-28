import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

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
        alignment: Alignment.center,
        child: SvgPicture.asset(
          asset.check,
          colorFilter: ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
          width: size * 0.5,
          height: size * 0.5,
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
        alignment: Alignment.center,
        child: SizedBox(
          child: SvgPicture.asset(
            asset.check,
            colorFilter: ColorFilter.mode(
              theme.neutral20,
              BlendMode.srcIn,
            ),
            width: size * 0.5,
            height: size * 0.5,
          ),
        ),
      );
    }
  }
}
