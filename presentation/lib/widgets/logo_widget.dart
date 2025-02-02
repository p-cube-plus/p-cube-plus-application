import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget(this.size, {super.key});

  final double size;
  final double padding = 6;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: theme.content,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(2, 0),
            blurRadius: 10,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        theme.mainLogoPath,
        width: size - padding * 2,
        height: size - padding * 2,
      ),
    );
  }
}
