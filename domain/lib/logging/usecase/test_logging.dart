import 'dart:developer';

import 'package:domain/logging/repository/logging_repository.dart';
import 'package:get_it/get_it.dart';

class TestLogging {
  final LoggingRepository _loggingRepository = GetIt.I.get<LoggingRepository>();

  void call() {
    _loggingRepository.logEvent(
      "test",
      {
        "test4": "test test",
        "test5": 1234,
        "test6": 9.99,
      },
    ).onError((error, __) {
      log("$error");
    }).then((_) {
      log("");
    });
  }
}
