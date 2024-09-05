import 'package:presentation/common/base_viewmodel.dart';

import 'home_attendance_content/home_attendance_content_data.dart';

class HomeAttendnaceViewModel extends BaseViewModel<void, void> {
  final List<HomeAttendanceContentData> contentDataList = [];

  Future<void> fetchData() async {}

  Future<void> refreshData() async {}
}
