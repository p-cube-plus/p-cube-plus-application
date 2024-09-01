import 'package:domain/models/user/user_warning_info_data.dart';

class UserWarningData {
  final Map<String, String> warningCategory;
  final List<UserWarningInfoData> warningAddList;
  final List<UserWarningInfoData> warningRemoveList;
  final int totalWarning;
  final int totalAddWarning;
  final int totalRemoveWarning;

  UserWarningData({
    required this.warningCategory,
    required this.warningAddList,
    required this.warningRemoveList,
    required this.totalWarning,
    required this.totalAddWarning,
    required this.totalRemoveWarning,
  });
}
