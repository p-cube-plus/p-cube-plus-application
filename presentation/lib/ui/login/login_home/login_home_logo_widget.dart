import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/constants/asset_path.dart' as path;
import 'package:presentation/extensions/theme_data_extension.dart';

class LoginHomeLogoWidget extends StatelessWidget {
  const LoginHomeLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SvgPicture.asset(
          path.textLogo,
          width: 240,
          height: 55,
        ),
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
              TextSpan(
                text: "플러스",
                style: TextStyle(
                  color: theme.primary80,
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
