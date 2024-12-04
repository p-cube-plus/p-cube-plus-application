enum MemberType {
  regular(isActiveMember: true), // 정회원
  trainee(isActiveMember: true), // 수습회원
  honorary(isActiveMember: false), // 명예회원
  graduating(isActiveMember: false), // 졸업회원
  ;

  final bool isActiveMember;
  const MemberType({required this.isActiveMember});
}
