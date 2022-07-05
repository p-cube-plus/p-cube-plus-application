class Curriculum {
  final int period, // 활동 기간
      workshopCount, // 워크샵 횟수
      projectCount; // 프로젝트 참여 횟수
  final String curriculumDescription; // 현재 커리큘럼
  final bool curriculumComplete, vote;
  final double progress; // 진행도

  Curriculum({
    required this.period,
    required this.workshopCount,
    required this.projectCount,
    required this.curriculumComplete,
    required this.curriculumDescription,
    required this.vote,
    required this.progress,
  });

  factory Curriculum.fromJson(Map<String, dynamic> json) {
    return Curriculum(
      period: json['period'],
      workshopCount: json['workshopCount'],
      projectCount: json['projectCount'],
      curriculumComplete: json['curriculumComplete'],
      curriculumDescription: json['curriculumDescription'],
      vote: json['vote'],
      progress: json['progress'],
    );
  }

  Map<String, dynamic> toJson() => {
        'period': period,
        'workshopCount': workshopCount,
        'projectCount': projectCount,
        'curriculumComplete': curriculumComplete,
        'curriculumDescription': curriculumDescription,
        'vote': vote,
        'progress': progress,
      };
}
