import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void routeHandler(String routeName) {
  navigatorKey.currentState?.pushNamed(routeName);
}
