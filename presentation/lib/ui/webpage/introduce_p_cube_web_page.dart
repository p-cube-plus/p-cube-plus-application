import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/app_view_model.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_mode_extension.dart';
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

class _IntroducePCubeWebPageState extends State<IntroducePCubeWebPage>
    with ViewModel<AppViewModel> {
  final url = "https://p-cube.notion.site/1629ed2459954343a62ea49d0d284f00";
  late final WebViewController controller;
  Brightness? prevBrightness;

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
      controller.loadRequest(Uri.parse(url));
    });
  }

  @override
  Widget build(BuildContext context) {
    // 웹뷰는 밝기를 시스템 설정을 따라가므로
    // 무조건 시스템 설정 따라가게 설정
    final systemBrightMode = MediaQuery.of(context).platformBrightness;

    final backgroundColor = (systemBrightMode == Brightness.light)
        ? Color(0xFFFFFFFF)
        : Color(0xFF212121);
    final contentColor = (systemBrightMode == Brightness.light)
        ? color.lightGray100
        : color.darkGray100;

    if (prevBrightness == null) {
      _setWebViewStatusBarSetting(context);
      controller.setBackgroundColor(backgroundColor);
      prevBrightness = systemBrightMode;
    } else if (prevBrightness != systemBrightMode) {
      controller.reload();
      _setWebViewStatusBarSetting(context);
      controller.setBackgroundColor(backgroundColor);
      prevBrightness = systemBrightMode;
    }

    return PopScope(
      onPopInvokedWithResult: (_, __) async {
        if (await controller.canGoBack()) {
          controller.goBack();
        } else {
          if (!context.mounted) return;
          _setOriginStatusBarSetting(context);
        }
      },
      child: DefaultPage(
        resizeToAvoidBottomInset: true,
        appbar: DefaultAppBar(
          backgroundColor: backgroundColor,
          contentColor: contentColor,
        ),
        bottomPadding: 0,
        backgroundColor: backgroundColor,
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

  void _setWebViewStatusBarSetting(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: ThemeMode.system.getStatusColor(context),
    ));
  }

  void _setOriginStatusBarSetting(BuildContext context) {
    final themeMode = read(context).currentThemeMode;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: themeMode.getStatusColor(context),
    ));
  }
}
