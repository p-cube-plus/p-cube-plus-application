import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/login/usecases/fetch_is_need_login_use_case.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void routeHandler(String routeName) async {
  final fetchIsUserLoggedIn = FetchIsNeedLoginUseCase();
  final isLogedIn = await fetchIsUserLoggedIn.call().getOrDefault(false);

  navigatorKey.currentState?.popUntil((route) => route.isFirst);
  if (!isLogedIn) {
    navigatorKey.currentState?.pushNamed("/login");
  } else {
    navigatorKey.currentState?.pushNamed(routeName);
  }
}
