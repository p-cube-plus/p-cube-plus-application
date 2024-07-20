class UserWarningDTO {
  final Map<String, String> warningCategory;
  final List<WarningInfoDTO> warningAddList;
  final List<WarningInfoDTO> warningRemoveList;
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
          .map<WarningInfoDTO>((data) => WarningInfoDTO.fromJson(data))
          .toList(),
      warningRemoveList: (json['warning_remove_list'] as List)
          .map<WarningInfoDTO>((data) => WarningInfoDTO.fromJson(data))
          .toList(),
      totalWarning: json['total_warning'],
      totalAddWarning: json['total_add_warning'],
      totalRemoveWarning: json['total_remove_warning'],
    );
  }

  Map<String, dynamic> toJson() => {
        'warning_category': warningCategory,
        'warning_add_list': warningAddList,
        'warning_remove_list': warningRemoveList,
        'total_warning': totalWarning,
        'total_add_warning': totalAddWarning,
        'total_remove_warning': totalRemoveWarning,
      };
}

class WarningInfoDTO {
  final int category;
  final DateTime? date;
  final String? description;
  final String? comment;
  final int id;

  WarningInfoDTO({
    required this.category,
    required this.date,
    required this.description,
    required this.comment,
    required this.id,
  });

  factory WarningInfoDTO.fromJson(Map<String, dynamic> json) {
    return WarningInfoDTO(
      category: json['category'],
      date: json['date'],
      description: json['description'],
      comment: json['comment'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'category': category,
        'date': date,
        'description': description,
        'comment': comment,
        'id': id,
      };
}
