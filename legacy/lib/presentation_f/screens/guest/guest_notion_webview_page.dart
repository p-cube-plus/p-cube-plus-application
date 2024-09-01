import 'dart:io';

import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/page/default_appbar.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GuestWebViewPage extends StatelessWidget {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) async {
          if (Platform.isAndroid &&
              request.url.startsWith("https://play.google.com/")) {
            await launchApp(request.url);
            return NavigationDecision.prevent;
          }

          if (Platform.isIOS &&
              request.url.startsWith("https://apps.apple.com/")) {
            await launchApp(request.url);
            return NavigationDecision.prevent;
          }

          if (request.url.startsWith("https://pf.kakao.com/")) {
            await launchApp(request.url);
            return NavigationDecision.prevent;
          }

          if (request.url.startsWith("intent"))
            return NavigationDecision.prevent;

          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(
        'https://p-cube.notion.site/1629ed2459954343a62ea49d0d284f00'));

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(
        bottomPadding: 0,
      ),
      content: WillPopScope(
          onWillPop: () async {
            if (await controller.canGoBack()) {
              controller.goBack();
              return false;
            } else {
              return true;
            }
          },
          child: WebViewWidget(controller: controller)),
    );
  }

  static Future<bool> launchApp(String url) async {
    final appUrl = Uri.parse(url);
    if (await canLaunchUrl(appUrl)) {
      return await launchUrl(appUrl);
    }
    return false;
  }
}
