import 'package:domain/member/value_objects/member_part_type.dart';

sealed class NotificationType {}

class RegularMettingNotification implements NotificationType {
  String get korean => "정기회의 알림";
}

class PartMettingNotification implements NotificationType {
  final MemberPartType partType;
  PartMettingNotification(this.partType);

  String get korean => "파트회의 알림";
  String get koreanWithPart => "${partType.korean} $korean";
}

class FeeNotification implements NotificationType {
  String get korean => "회비 알림";
}

class CleaningNotification implements NotificationType {
  String get korean => "청소 알림";
}

class RentNotification implements NotificationType {
  String get korean => "기타 알림";
}
