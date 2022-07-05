class Seminar {
  final int type; // 0 수습, 1 정회원, 2 졸업생?
  final String description;
  final DateTime date; // 시작 시간

  Seminar({
    required this.type,
    required this.description,
    required this.date,
  });

  factory Seminar.fromJson(Map<String, dynamic> json) {
    return Seminar(
      type: json['type'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'description': description,
        'date': date.toString(),
      };
}
