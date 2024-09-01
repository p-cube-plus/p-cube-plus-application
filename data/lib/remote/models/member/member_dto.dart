import 'package:domain/models/member/member_data.dart';

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

extension MemberDTOExtension on MemberDTO {
  MemberData toDomain() {
    return MemberData(
      isSigned: isSigned,
      name: name,
      level: level,
      partIdx: partIdx,
      profileImage: profileImage,
    );
  }
}
