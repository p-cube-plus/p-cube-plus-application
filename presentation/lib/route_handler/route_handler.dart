import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/login/usecases/fetch_is_need_login_use_case.dart';
import 'package:flutter/material.dart';
import 'package:presentation/route_handler/route_type.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void routeHandler(RouteType routeType) async {
  final fetchIsUserLoggedIn = FetchIsNeedLoginUseCase();
  final isLogedIn = await fetchIsUserLoggedIn.call().getOrDefault(false);

  if (!isLogedIn) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      RouteType.login.routeName,
      (route) => false,
    );
  } else {
    navigatorKey.currentState?.popUntil((route) => false);
    for (final routeName in routeType.routePath) {
      navigatorKey.currentState?.pushNamed(routeName);
    }
  }
}
