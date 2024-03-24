import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/models/enum/state_type.dart';

extension StateTypeExtension on StateType {
  Image toImage(double size) {
    return Image.asset("assets/images/${this.toString().split('.').last}.png",
        width: size, height: size);
  }

  String toAttendanceString(StateType type, double size) {
    switch (type) {
      case StateType.none:
        return "없음";
      case StateType.off:
        return "대기";
      case StateType.negative:
        return "불참";
      case StateType.late:
        return "지각";
      case StateType.positive:
        return "참석";
    }
  }
}
