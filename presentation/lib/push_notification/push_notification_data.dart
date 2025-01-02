import 'package:domain/notification/value_objects/notification_type.dart';

enum PushNotificationType {
  etc(999),
  regularMetting(1),
  partMetting(2),
  fee(3),
  cleaning(4),
  rent(5),
  ;

  const PushNotificationType(this.notificationId);
  final int notificationId;

  NotificationType toNotificationType() {
    return switch (this) {
      PushNotificationType.etc => TestNotification(),
      PushNotificationType.regularMetting => RegularMettingNotification(),
      PushNotificationType.partMetting => PartMettingNotification(null),
      PushNotificationType.fee => FeeNotification(),
      PushNotificationType.cleaning => CleaningNotification(),
      PushNotificationType.rent => RentNotification(),
    };
  }
}

class PushNotificationData {
  final PushNotificationType type;
  final String title;
  final String descrption;
  const PushNotificationData({
    required this.type,
    required this.title,
    required this.descrption,
  });

  PushNotificationData.fcm(
    String typeString, {
    required this.title,
    required this.descrption,
  }) : type = (() {
          if (typeString == "정기회의") return PushNotificationType.regularMetting;
          if (typeString == "파트회의") return PushNotificationType.partMetting;
          if (typeString == "회비") return PushNotificationType.fee;
          if (typeString == "청소") return PushNotificationType.cleaning;
          if (typeString == "대여") return PushNotificationType.rent;
          return PushNotificationType.etc;
        }).call();
}
