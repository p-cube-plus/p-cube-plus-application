class Project {
  final int type; // 메인, 꼬꼬마, 등등
  final String name; // 프로젝트 이름
  final DateTime begin; // 시작 시간
  final DateTime? end; // 종료 시간 -> null이면 아직 미완료?
  final bool isEnd;
  final List<String> members;

  Project({
    required this.type,
    required this.name,
    required this.isEnd,
    required this.begin,
    this.end,
    required this.members,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      type: json['type'],
      name: json['name'],
      isEnd: json['is_end'],
      begin: DateTime.parse(json['begin']),
      end: json['is_end'] ? DateTime.parse(json['end']) : null,
      members: (json['members'] as List<dynamic>)
          .map<String>((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'is_end': isEnd,
        'begin': begin.toString(),
        'end': end?.toString() ?? null,
        'members': members,
      };
}
