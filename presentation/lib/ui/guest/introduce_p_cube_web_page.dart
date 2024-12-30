import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:presentation/constants/app_color.dart' as color;
import 'package:url_launcher/url_launcher.dart';

class IntroducePCubeWebPage extends StatefulWidget {
  const IntroducePCubeWebPage({super.key});

  @override
  State<IntroducePCubeWebPage> createState() => _IntroducePCubeWebPageState();
}

class _IntroducePCubeWebPageState extends State<IntroducePCubeWebPage> {
  final url = "https://p-cube.notion.site/1629ed2459954343a62ea49d0d284f00";
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            if (isAvailableLink(request.url)) {
              final availableUrl = Uri.parse(request.url);
              final canLaunch = await canLaunchUrl(availableUrl);

              if (canLaunch) {
                await launchUrl(availableUrl);
                return NavigationDecision.prevent;
              } else {
                return NavigationDecision.navigate;
              }
            }

            Fluttertoast.showToast(msg: "해당 주소로 접근할 수 없습니다.");
            return NavigationDecision.prevent;
          },
        ),
      );

    Future.microtask(() {
      final systemBrightMode = MediaQuery.of(context).platformBrightness;
      final backgoundColor = (systemBrightMode == Brightness.light)
          ? Color(0xFFFFFFFF)
          : Color(0xFF212121);
      controller
        ..setBackgroundColor(backgoundColor)
        ..loadRequest(Uri.parse(url));
    });
  }

  @override
  Widget build(BuildContext context) {
    final systemBrightMode = MediaQuery.of(context).platformBrightness;
    final backgoundColor = (systemBrightMode == Brightness.light)
        ? Color(0xFFFFFFFF)
        : Color(0xFF212121);
    final contentColor = (systemBrightMode == Brightness.light)
        ? color.lightGray100
        : color.darkGray100;

    return PopScope(
      onPopInvokedWithResult: (didPop, __) async {
        if (await controller.canGoBack()) {
          controller.goBack();
        }
      },
      child: DefaultPage(
        resizeToAvoidBottomInset: true,
        appbar: DefaultAppBar(
          backgroundColor: backgoundColor,
          contentColor: contentColor,
        ),
        bottomPadding: 0,
        backgroundColor: backgoundColor,
        contentColor: contentColor,
        content: WebViewWidget(controller: controller),
      ),
    );
  }

  bool isAvailableLink(String url) {
    return url.contains("store.steampowered.com") ||
        url.contains("play.google.com") ||
        url.contains("store.onstove.com") ||
        url.contains("kakao.com") ||
        url.contains("p-cube.kr") ||
        url.contains("docs.google.com/forms");
  }
}
