class ProjectResponseDTO {
  final int id;
  final String name;

  final String? type;
  //String getType() => "${["메인", "꼬꼬마"][type]}";

  final String status;
  //String getStatus() =>
  //    "${["종료(완성)", "진행중", "준비중", "동결", "종료 임박", "종료(미완성)"][status]}";

  final DateTime? startDate;
  final DateTime? endDate;
  final String? graphic; // tag
  final List<String> platforms; // tag
  final bool isFindingMember;
  final bool isAbleInquiry; // 문의 가능한지

  final MemberDTO pm;
  final List<MemberDTO> members;

  ProjectResponseDTO({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.graphic,
    required this.platforms,
    required this.isFindingMember,
    required this.isAbleInquiry,
    required this.pm,
    required this.members,
  });

  factory ProjectResponseDTO.fromJson(Map<String, dynamic> json) {
    var platformList = json['platform']
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map<String>((e) {
      return e.replaceAll(" ", "");
    }).toList();

    return ProjectResponseDTO(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      status: json['status'],
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date']),
      endDate:
          json['end_date'] == null ? null : DateTime.parse(json['end_date']),
      graphic: json['graphic'],
      platforms: platformList,
      isFindingMember: json['is_finding_member'],
      isAbleInquiry: json['is_able_inquiry'],
      pm: MemberDTO.fromJson(json['pm']),
      members: (json['members'] as List)
          .map<MemberDTO>((data) => MemberDTO.fromJson(data))
          .toList(),
    );
  }
}

class MemberDTO {
  final bool isSigned; // 가입 여부
  final String name;
  final int level; // 정회원, 수습, 졸업, 탈퇴
  final int partIdx;
  final String? profileImage;

  MemberDTO({
    required this.isSigned,
    required this.name,
    required this.level,
    required this.partIdx,
    required this.profileImage,
  });

  factory MemberDTO.fromJson(Map<String, dynamic> json) {
    return MemberDTO(
      isSigned: json['is_signed'],
      name: json['name'],
      level: json['level'],
      partIdx: json['part_index'],
      profileImage: json['profile_image'],
    );
  }
}
