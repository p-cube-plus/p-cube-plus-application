import 'package:flutter/material.dart';
import '../models/notice_box.dart';

class NoticeList with ChangeNotifier {
  // DUMMY
  bool isFirst = true;

  List<NoticeBox> curList = [];

  // 새 알림을 얻는 함수
  // 가까운 날짜 순서로 정렬 (오름차순)
  void getNotice(NoticeBox notice) {
    curList.add(notice);
    curList.sort((a, b) => (a.date).compareTo(b.date));
    notifyListeners();
  }

  void deleteNotice(int idx) {
    curList.removeAt(idx);
    notifyListeners();
  }
}
