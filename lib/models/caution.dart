class Caution {
  final int type;
  final int count;
  final String description;
  final DateTime date;

  Caution({
    required this.type,
    required this.description,
    required this.date,
    required this.count,
  });

  factory Caution.fromJson(Map<String, dynamic> json) {
    return Caution(
      type: json['type'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'count': count,
        'description': description,
        'date': date.toString(),
      };
}
