sealed class MemberPositionType {}

sealed class ExecutiveTeam implements MemberPositionType {}
class RegularMember implements MemberPositionType {}
class TraineeMember implements MemberPositionType {}
class HonoraryMember implements MemberPositionType {}
class GraduatingMember implements MemberPositionType {}

class Chairman implements ExecutiveTeam {}
class ViceChairman implements ExecutiveTeam {}
class Clerk implements ExecutiveTeam {}
class ProgrammingPartLeader implements ExecutiveTeam {}
class DesignPartLeader implements ExecutiveTeam {}
class ArtPartLeader implements ExecutiveTeam {}
