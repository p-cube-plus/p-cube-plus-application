class SeminarResponseDTO {
  String title;
  String url;
  String category;
  String date;
  int id;
  SeminarResponseDTO({
    required this.title,
    required this.url,
    required this.category,
    required this.date,
    required this.id,
  });

  factory SeminarResponseDTO.fromJson(Map<String, dynamic> map) {
    return SeminarResponseDTO(
      title: map['title'] as String,
      url: map['url'] as String,
      category: map['category'] as String,
      date: map['date'] as String,
      id: map['id'] as int,
    );
  }
}
