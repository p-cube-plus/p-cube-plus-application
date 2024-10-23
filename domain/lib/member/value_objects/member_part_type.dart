enum MemberPartType {
  design('디자인'),
  art('아트'),
  development('프로그래밍'),
  ;

  final String name;
  const MemberPartType(this.name);

  @override
  String toString() => name;
}
