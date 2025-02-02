import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_mode_extension.dart';
import 'package:presentation/ui/webpage/introduce_p_cube_view_model.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:presentation/constants/app_color.dart' as color;
import 'package:url_launcher/url_launcher.dart';

class IntroducePCubeWebPage extends StatelessWidget {
  const IntroducePCubeWebPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IntroducePCubeViewModel(),
      child: _IntroducePCubeWebPage(),
    );
  }
}

class _IntroducePCubeWebPage extends StatefulWidget {
  const _IntroducePCubeWebPage();

  @override
  State<_IntroducePCubeWebPage> createState() => _IntroducePCubeWebPageState();
}

class _IntroducePCubeWebPageState extends State<_IntroducePCubeWebPage>
    with ViewModel<IntroducePCubeViewModel> {
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
            final availableUrl = Uri.parse(request.url);
            final canLaunch = await canLaunchUrl(availableUrl);

            if (canLaunch) {
              await launchUrl(availableUrl);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
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

    final isChangedSystemBrightness = prevBrightness != systemBrightMode;
    if (isChangedSystemBrightness) {
      controller.reload();
      _setWebViewStatusBarSetting(context);
      controller.setBackgroundColor(backgroundColor);
      prevBrightness = systemBrightMode;
    }

    return PopScope(
      onPopInvokedWithResult: (_, __) async {
        if (await controller.canGoBack()) {
          controller.goBack();
        }
      },
      child: DefaultPage(
        appbar: DefaultAppBar(
          backgroundColor: backgroundColor,
          contentColor: contentColor,
          centerTitle: "판도라큐브 소개",
        ),
        bottomPadding: 0,
        backgroundColor: backgroundColor,
        contentColor: contentColor,
        content: Container(
          color: backgroundColor,
          child: DefaultFutureBuilder(
            fetchData: read(context).fetchWebViewUrl(),
            showOnLoadedWidget: (context, url) {
              controller.loadRequest(Uri.parse(url));
              return WebViewWidget(controller: controller);
            },
          ),
        ),
      ),
    );
  }

  void _setWebViewStatusBarSetting(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: ThemeMode.system.getStatusColor(context),
    ));
  }
}
