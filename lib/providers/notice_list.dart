import 'package:flutter/material.dart';
import '../models/notice_box.dart';

class NoticeList with ChangeNotifier {
  // DUMMY
  bool isFirst = true;

  List<NoticeBox> curList = [];
  List<NoticeBox> prevList = [];

  // 새 알림을 얻는 함수
  // 가까운 날짜 순서로 정렬 (오름차순)
  void getNotice(NoticeBox notice) {
    curList.add(notice);
    curList.sort((a, b) => (a.date).compareTo(b.date));
    notifyListeners();
  }

  // 알림의 기한이 끝나 현재 알림에서 과거 기록 알림으로 변경
  // 가까운 날짜 순서로 정렬 (내림차순) ~ 정렬할 필요 없음, 저절로 정렬
  void putPrevNotice() {
    prevList.add(curList.removeAt(0));

    // 만약, 과거 리스트가 50개가 넘어간다면 가장 마지막을 삭제
    if (prevList.length > 50) prevList.removeLast();

    notifyListeners();
  }

  void deletePrevNotice(int idx) {
    prevList.removeAt(idx);
    notifyListeners();
  }
}
