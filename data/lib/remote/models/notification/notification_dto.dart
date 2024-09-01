import 'package:domain/models/notification/notification_data.dart';

class NotificationDTO {
  final int id;
  final int type;
  final String date;
  final String description;
  final String name;

  NotificationDTO({
    required this.date,
    required this.description,
    required this.id,
    required this.name,
    required this.type,
  });

  factory NotificationDTO.fromJson(Map<String, dynamic> json) {
    return NotificationDTO(
      id: json['id'],
      type: json['type'],
      date: json['date'],
      description: json['description'],
      name: json['name'],
    );
  }
}

extension NotificationDTOExtension on NotificationDTO {
  NotificationData toDomain() {
    return NotificationData(
      date: date,
      description: description,
      id: id,
      name: name,
      type: type,
    );
  }
}
