import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/services/notice_api.dart';
import '../models/notification_node.dart';

enum SortType {
  Ascending,
  Descending,
}

class NoticeProvider with ChangeNotifier {
  NoticeListApi _client = new NoticeListApi();
  List<NotificationNode> _noticeList = [];
  SortType _sortType = SortType.Ascending;

  Future<List<NotificationNode>> update() async {
    _noticeList = await _client.get() ?? [];
    notifyListeners();
    return _noticeList;
  }

  void addNotice(NotificationNode notice) {
    _noticeList.add(notice);
    _sort();
    notifyListeners();
  }

  void deleteNotice(int idx) {
    _noticeList.removeAt(idx);
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
        _noticeList.sort((a, b) => (a.date).compareTo(b.date));
        break;
      case SortType.Descending:
        _noticeList.sort((a, b) => (b.date).compareTo(a.date));
        break;
    }
  }

  List<NotificationNode> _getDummy() {
    return <NotificationNode>[
      NotificationNode(
        date: DateTime(2023, 09, 28).toString(),
        description: "메이플을 접던가 해야지 원",
        id: 0,
        name: "목요일마다 주간보스 잡기",
        type: 0,
      ),
      NotificationNode(
        date: DateTime(2023, 09, 28).toString(),
        description: "저도 잘 모르겠네요...",
        id: 0,
        name: "이거 테스트는 언제해요?",
        type: 0,
      ),
    ];
  }
}
