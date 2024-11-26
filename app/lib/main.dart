import 'package:flutter/material.dart';
import 'package:presentation/p_cube_plus_app.dart';
import 'regist_service.dart' as ioc;
import 'initialize_on_app_start.dart' as init;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ioc.registService();
  await init.initializeOnAppStart();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (_) {}

  runApp(const PCubePlusApp());
}
