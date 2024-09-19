import 'user_warning_info_dto.dart';

class UserWarningDTO {
  final Map<String, String> warningCategory;
  final List<UserWarningInfoDTO> warningAddList;
  final List<UserWarningInfoDTO> warningRemoveList;
  final int totalWarning;
  final int totalAddWarning;
  final int totalRemoveWarning;

  UserWarningDTO({
    required this.warningCategory,
    required this.warningAddList,
    required this.warningRemoveList,
    required this.totalWarning,
    required this.totalAddWarning,
    required this.totalRemoveWarning,
  });

  factory UserWarningDTO.fromJson(Map<String, dynamic> json) {
    return UserWarningDTO(
      warningCategory: Map<String, String>.from(json['warning_category']),
      warningAddList: (json['warning_add_list'] as List)
          .map<UserWarningInfoDTO>((data) => UserWarningInfoDTO.fromJson(data))
          .toList(),
      warningRemoveList: (json['warning_remove_list'] as List)
          .map<UserWarningInfoDTO>((data) => UserWarningInfoDTO.fromJson(data))
          .toList(),
      totalWarning: json['total_warning'],
      totalAddWarning: json['total_add_warning'],
      totalRemoveWarning: json['total_remove_warning'],
    );
  }
}
