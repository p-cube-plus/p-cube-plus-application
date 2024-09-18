class AddSeminarBodyDTO {
  String title;
  String url;
  String category;
  String date;
  int id;
  AddSeminarBodyDTO({
    required this.title,
    required this.url,
    required this.category,
    required this.date,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'url': url,
      'category': category,
      'date': date,
      'id': id,
    };
  }
}
