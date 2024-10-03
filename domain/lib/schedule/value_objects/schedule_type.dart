import 'package:domain/common/value_objects/color.dart';

sealed class ScheduleType {
  final Color color;
  ScheduleType(this.color);
}

class ScheduleTypMain implements ScheduleType {
  @override
  Color get color => Color(0xFFDE2B13);
}

class ScheduleTypeClean implements ScheduleType {
  @override
  Color get color => Color(0xFF5EDCA7);
}

class ScheduleWorkShop implements ScheduleType {
  @override
  Color get color => Color(0xFF4813DE);
}
