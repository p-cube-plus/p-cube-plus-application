enum MemberPartType {
  design('디자인'),
  art('아트'),
  development('프로그래밍'),
  ;

  final String korean;
  const MemberPartType(this.korean);

  @override
  String toString() => korean;
}
