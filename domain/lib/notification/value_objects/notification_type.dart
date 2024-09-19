import 'package:domain/member/value_objects/member_part_type.dart';

sealed class NotificationType {}

class RegularMettingNotification implements NotificationType {}

class PartMettingNotification implements NotificationType {
  final MemberPartType partType;
  PartMettingNotification(this.partType);
}

class FeeNotification implements NotificationType {}

class CleaningNotification implements NotificationType {}

class RentNotification implements NotificationType {}
