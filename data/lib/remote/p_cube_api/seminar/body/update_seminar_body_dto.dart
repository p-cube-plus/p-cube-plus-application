class UpdateSeminarBodyDTO {
  String title;
  String url;
  String category;
  String date;
  UpdateSeminarBodyDTO({
    required this.title,
    required this.url,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'url': url,
      'category': category,
      'date': date,
    };
  }
}
