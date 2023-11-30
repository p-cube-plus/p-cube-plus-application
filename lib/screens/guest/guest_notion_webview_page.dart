import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/page/default_appbar.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GuestWebViewPage extends StatelessWidget {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (!request.url.startsWith('https://p-cube.notion.site/')) {
            return NavigationDecision.prevent;
          }
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
      content: WebViewWidget(controller: controller),
    );
  }
}
