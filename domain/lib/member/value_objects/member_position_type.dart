sealed class MemberPositionType {}

class RegularMember implements MemberPositionType {
  @override
  String toString() => "정회원";
}

class TraineeMember implements MemberPositionType {
  @override
  String toString() => "수습회원";
}

class HonoraryMember implements MemberPositionType {
  @override
  String toString() => "명예회원";
}

class GraduatingMember implements MemberPositionType {
  @override
  String toString() => "졸업회원";
}

sealed class ExecutiveTeam implements RegularMember {
  @override
  String toString() => "임원진";
}

class Chairman implements ExecutiveTeam {
  @override
  String toString() => "회장";
}

class ViceChairman implements ExecutiveTeam {
  @override
  String toString() => "부회장";
}

class Clerk implements ExecutiveTeam {
  @override
  String toString() => "서기";
}

class ProgrammingPartLeader implements ExecutiveTeam {
  @override
  String toString() => "프로그래밍 파트장";
}

class DesignPartLeader implements ExecutiveTeam {
  @override
  String toString() => "디자인 파트장";
}

class ArtPartLeader implements ExecutiveTeam {
  @override
  String toString() => "아트 파트장";
}
