import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/presentation/screens/login_page/logo_widget.dart';
import 'package:p_cube_plus_application/presentation/view/login_page/login_button_widgets.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return DefaultPage(
      backgroundColor: theme.colorScheme.background,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          LogoWidget(),
          LoginButtonWidgets(),
        ],
      ),
    );
  }
}
