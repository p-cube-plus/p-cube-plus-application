class NotificationResponseDTO {
  final int id;
  final int type;
  final String date;
  final String description;
  final String name;

  NotificationResponseDTO({
    required this.date,
    required this.description,
    required this.id,
    required this.name,
    required this.type,
  });

  factory NotificationResponseDTO.fromJson(Map<String, dynamic> json) {
    return NotificationResponseDTO(
      id: json['id'],
      type: json['type'],
      date: json['date'],
      description: json['description'],
      name: json['name'],
    );
  }
}
