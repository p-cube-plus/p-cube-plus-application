import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/common/utils/contants.dart';
import 'package:p_cube_plus_application/common/utils/theme.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        Constants.GetIcon(Constants.main_text_logo),
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
                  color: theme.textTheme.headlineSmall!.color,
                ),
              ),
              TextSpan(
                text: "플러스",
                style: TextStyle(
                  color: MyThemes.primary80,
                ),
              ),
              TextSpan(
                text: "가 되다",
                style: TextStyle(
                  color: theme.textTheme.headlineSmall!.color,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
