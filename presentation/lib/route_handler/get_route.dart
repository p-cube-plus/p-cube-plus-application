import 'package:flutter/material.dart';
import 'package:presentation/route_handler/route_type.dart';
import 'package:presentation/ui/login/login_home/login_home_page.dart';
import 'package:presentation/ui/main/main_navigation_bar_factory.dart';
import 'package:presentation/ui/main/main_page.dart';

Map<String, Widget Function(BuildContext)> getRoute() {
  return {
    RouteType.login.routeName: (context) => LoginHomePage(),
    RouteType.alarm.routeName: (context) =>
        MainPage(initializeType: MainNavigationType.alarm),
    RouteType.home.routeName: (context) =>
        MainPage(initializeType: MainNavigationType.home),
    RouteType.user.routeName: (context) =>
        MainPage(initializeType: MainNavigationType.user),
  };
}
