import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/constants/asset_path.dart' as path;
import 'package:presentation/constants/app_color.dart' as color;
import 'package:presentation/theme/text_theme_extension.dart';

class LoginHomeLogoWidget extends StatelessWidget {
  const LoginHomeLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SvgPicture.asset(path.textLogo),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: const TextStyle(
                fontFamily: "Spectral SC",
                fontWeight: FontWeight.w700,
                fontSize: 16.0),
            children: [
              TextSpan(
                text: "판도라큐브에 ",
                style: TextStyle(
                  color: theme.neutral80,
                ),
              ),
              const TextSpan(
                text: "플러스",
                style: TextStyle(
                  color: color.primary80,
                ),
              ),
              TextSpan(
                text: "가 되다",
                style: TextStyle(
                  color: theme.neutral80,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
