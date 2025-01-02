import 'package:flutter/material.dart';
import 'package:presentation/p_cube_plus_app.dart';
import 'regist_service.dart' as ioc;
import 'firebase_setting.dart' as firebase_setting;
import 'package:data/app_start_up_functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ioc.registService();
  await firebase_setting.initializeFirebaseService();

  final isLoggedIn = await getLoggedIn();
  runApp(PCubePlusApp(isLoggedIn));
}
