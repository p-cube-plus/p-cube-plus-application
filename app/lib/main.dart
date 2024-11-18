import 'package:flutter/material.dart';
import 'package:presentation/p_cube_plus_app.dart';
import 'regist_service.dart' as ioc;
import 'initialize_on_app_start.dart' as init;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ioc.registService();
  await init.initializeOnAppStart();
  runApp(const PCubePlusApp());
}
