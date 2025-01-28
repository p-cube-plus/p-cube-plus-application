import 'package:flutter/material.dart';
import 'package:presentation/widgets/logo_splash_widget.dart';

class DefaultProgressIndicatorBuilder {
  Future build(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => PopScope(
        canPop: false,
        child: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            Center(child: LogoSplashWidget(size: 64)),
          ],
        ),
      ),
    );
  }
}
