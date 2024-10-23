import 'package:domain/member/value_objects/member_part_type.dart';

sealed class NotificationType {
  final String name;
  NotificationType(this.name);
}

class RegularMettingNotification implements NotificationType {
  @override
  String get name => "정기회의 알림";
}

class PartMettingNotification implements NotificationType {
  final MemberPartType partType;
  PartMettingNotification(this.partType);

  @override
  String get name => "${partType.name} 파트회의 알림";
}

class FeeNotification implements NotificationType {
  @override
  String get name => "회비 알림";
}

class CleaningNotification implements NotificationType {
  @override
  String get name => "청소 알림";
}

class RentNotification implements NotificationType {
  @override
  String get name => "기타 알림";
}
