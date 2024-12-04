sealed class MemberType {
  final bool isActiveMember;
  MemberType(this.isActiveMember);
}

class TraineeMember implements MemberType {
  @override
  bool get isActiveMember => true;

  @override
  String toString() => "수습회원";
}

class RegularMember implements MemberType {
  @override
  bool get isActiveMember => true;

  @override
  String toString() => "정회원";
}

class ExecutiveMember implements MemberType {
  final String role;
  ExecutiveMember(this.role);

  @override
  bool get isActiveMember => true;

  @override
  String toString() => "임원진";
}

class DormantMember implements MemberType {
  @override
  bool get isActiveMember => false;

  @override
  String toString() => "명예회원";
}

class GraduateMember implements MemberType {
  @override
  bool get isActiveMember => false;

  @override
  String toString() => "졸업회원";
}
