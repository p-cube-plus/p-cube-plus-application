import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Warning {
  final Map<String, String> warningCategory;
  final List<WarningInfo> warningAddList;
  final List<WarningInfo> warningRemoveList;
  final int totalWarning;
  final int totalAddWarning;
  final int totalRemoveWarning;

  Warning({
    required this.warningCategory,
    required this.warningAddList,
    required this.warningRemoveList,
    required this.totalWarning,
    required this.totalAddWarning,
    required this.totalRemoveWarning,
  });

  factory Warning.fromJson(Map<String, dynamic> json) {
    return Warning(
      warningCategory: Map<String, String>.from(json['warning_category']),
      warningAddList: (json['warning_add_list'] as List)
          .map<WarningInfo>((data) => WarningInfo.fromJson(data))
          .toList(),
      warningRemoveList: (json['warning_remove_list'] as List)
          .map<WarningInfo>((data) => WarningInfo.fromJson(data))
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

@JsonSerializable()
class WarningInfo {
  final int category;
  final DateTime? date;
  final String? description;
  final String? comment;
  final int id;

  WarningInfo({
    required this.category,
    required this.date,
    required this.description,
    required this.comment,
    required this.id,
  });

  factory WarningInfo.fromJson(Map<String, dynamic> json) {
    return WarningInfo(
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
