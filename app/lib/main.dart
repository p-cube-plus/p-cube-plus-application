import 'package:flutter/material.dart';
import 'package:presentation/p_cube_plus_app.dart';
import 'regist_service.dart' as ioc;
import 'package:data/initialize_on_app_start.dart' as data_init;
import 'firebase_setting.dart' as firebase_setting;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await data_init.initializeOnAppStart();
  ioc.registService();

  await firebase_setting.initializeFirebaseService();

  runApp(const PCubePlusApp());
}
