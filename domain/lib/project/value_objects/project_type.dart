enum ProjectType {
  main,
  trainee,
  study;

  @override
  String toString() {
    return switch (this) {
      ProjectType.main => "메인 프로젝트",
      ProjectType.trainee => "꼬꼬마 프로젝트",
      ProjectType.study => "스터디",
    };
  }
}
