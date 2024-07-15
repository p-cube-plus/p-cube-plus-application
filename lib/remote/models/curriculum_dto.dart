class CurriculumDTO {
  final bool completed;
  final String? name;
  final DateTime? startDate;
  final DateTime? endDate;

  CurriculumDTO({
    required this.completed,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  factory CurriculumDTO.fromJson(Map<String, dynamic> json) {
    return CurriculumDTO(
      completed: json['completed'],
      name: json['current_curriculum'],
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date']),
      endDate:
          json['end_date'] == null ? null : DateTime.parse(json['end_date']),
    );
  }
}
