import 'dart:convert';

import 'package:p_cube_plus_application/models/enum/state_type.dart';

extension StringExtensions on String {
  List convertToJsonList() {
    return jsonDecode(this) as List;
  }

  StateType toStateType() {
    switch (this) {
      case "없음":
        return StateType.none;
      case "대기":
        return StateType.off;
      case "불참":
        return StateType.negative;
      case "지각":
        return StateType.late;
      case "참석":
        return StateType.positive;
    }
    return StateType.none;
  }
}
