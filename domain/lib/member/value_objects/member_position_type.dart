sealed class MemberPositionType {}

class RegularMember implements MemberPositionType {} // 정회원

class TraineeMember implements MemberPositionType {} // 수습회원

class HonoraryMember implements MemberPositionType {} // 명예회원

class GraduatingMember implements MemberPositionType {} // 졸업회원

sealed class ExecutiveTeam implements MemberPositionType {} // 임원진

class Chairman implements ExecutiveTeam {} // 회장

class ViceChairman implements ExecutiveTeam {} // 부회장

class Clerk implements ExecutiveTeam {} // 서기

class ProgrammingPartLeader implements ExecutiveTeam {} // 프로그래밍 파트장

class DesignPartLeader implements ExecutiveTeam {} // 디자인 파트장

class ArtPartLeader implements ExecutiveTeam {} // 아트 파트장
