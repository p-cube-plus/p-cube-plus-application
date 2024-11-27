import 'package:app/firebase_options.dart';
import 'package:data/initialize_on_app_start.dart' as data_init;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future initializeOnAppStart() async {
  await data_init.initOnAppStart();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
}
