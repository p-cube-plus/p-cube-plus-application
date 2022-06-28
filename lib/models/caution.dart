class Caution {
  final int type;
  final String description;
  final DateTime date;

  Caution({
    required this.type,
    required this.description,
    required this.date,
  });

  factory Caution.fromJson(Map<String, dynamic> json) {
    return Caution(
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
