import 'package:p_cube_plus_application/remote_f/models/notification_dto.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/services/user_api.dart';

enum SortType {
  Ascending,
  Descending,
}

class NoticeProvider extends ApiProviderBase<List<NotificationDTO>> {
  NoticeProvider() : super(getFunction: NoticeListApi().get);

  SortType _sortType = SortType.Ascending;

  void addNotice(NotificationDTO notice) async {
    // TODO: DB에 알림 추가

    _sort();
    notifyListeners();
  }

  void deleteNotice(int idx) async {
    // TODO: DB에 알림 삭제

    notifyListeners();
  }

  void changeSortType(SortType type) {
    _sortType = type;
    _sort();
    notifyListeners();
  }

  void _sort() {
    switch (_sortType) {
      case SortType.Ascending:
        data.sort((a, b) => (a.date).compareTo(b.date));
        break;
      case SortType.Descending:
        data.sort((a, b) => (b.date).compareTo(a.date));
        break;
    }
  }
}
