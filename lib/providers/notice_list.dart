import 'package:flutter/material.dart';

class NoticeList with ChangeNotifier {
  // DUMMY
  bool isFirst = true;

  final int title = 0;
  final int description = 1;
  final int date = 2;

  List<List<String>> curList = [];
  List<List<String>> prevList = [];

  // 새 알림을 얻는 함수
  // 가까운 날짜 순서로 정렬 (오름차순)
  void getNotice(String _title, String _description, String _date) {
    curList.add(List.unmodifiable([_title, _description, _date]));
    curList.sort((a, b) => a[date].compareTo(b[date]));
    notifyListeners();
  }

  // 알림의 기한이 끝나 현재 알림에서 과거 기록 알림으로 변경
  // 가까운 날짜 순서로 정렬 (내림차순)
  void putPrevNotice() {
    prevList.add(curList.removeAt(0));
    prevList.sort((a, b) => b[date].compareTo(a[date]));

    // 만약, 과거 리스트가 50개가 넘어간다면 가장 마지막을 삭제
    if (prevList.length > 50) prevList.removeLast();

    notifyListeners();
  }

  void deletePrevNotice(int idx) {
    prevList.removeAt(idx);
    notifyListeners();
  }
}
