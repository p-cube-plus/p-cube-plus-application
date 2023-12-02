import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Warning {
  final Map<int, String> warningCategory;
  final List<WarningInfo> warningAddList;
  final List<WarningInfo> warningRemoveList;
  final double warningTotal;

  Warning({
    required this.warningCategory,
    required this.warningAddList,
    required this.warningRemoveList,
    required this.warningTotal,
  });

  factory Warning.fromJson(Map<String, dynamic> json) {
    return Warning(
      warningCategory: json['warning_category'],
      warningAddList: json['warning_add_list'],
      warningRemoveList: json['warning_remove_list'],
      warningTotal: json['warning_total'],
    );
  }

  Map<String, dynamic> toJson() => {
        'warning_category': warningCategory,
        'warning_add_list': warningAddList,
        'warning_remove_list': warningRemoveList,
        'warning_total': warningTotal,
      };
}

@JsonSerializable()
class WarningInfo {
  final String category;
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
