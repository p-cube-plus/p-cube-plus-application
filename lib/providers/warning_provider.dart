import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/models/warning.dart';
import 'package:p_cube_plus_application/services/warning_api.dart';

class WarningProvider with ChangeNotifier {
  WarningApi _warningApi = new WarningApi();
  Warning? _warning;
  Warning? get warning => _warning;

  double _warningAddCount = 0;
  double get warningAddCount => _warningAddCount;
  double _warningRemoveCount = 0;
  double get warningRemoveCount => _warningRemoveCount;

  Future<Warning?> update() async {
    _warning = await _warningApi.getWarningList();
    notifyListeners();
    return _warning;
  }
}
