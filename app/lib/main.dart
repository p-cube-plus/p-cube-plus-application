import 'package:flutter/material.dart';
import 'package:presentation/p_cube_plus_app.dart';
import 'regist_service.dart' as ioc;
import 'firebase_setting.dart' as firebase_setting;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    ioc.registService(),
    firebase_setting.initializeFirebaseService(),
  ]);

  runApp(const PCubePlusApp());
}
