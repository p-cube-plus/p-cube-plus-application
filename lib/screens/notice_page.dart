import 'dart:collection';

import 'package:flutter/material.dart';

// DUMMY
bool isFirst = true;
enum NoticeType { title, description, date }
const int title = 0;
const int description = 1;
const int date = 2;

// 알림은 앱 실행 도중 변경 가능한 위젯
class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  // NoticeType map의 list
  final _mapList = <Map>[]; // 현재 알림
  final _prevList2 = <Map>[]; // 과거 기록 알림

  // 새 알림을 얻는 함수
  void GetNotice(String _title, String _description, String _date) {
    final noticeMap = new Map();
    noticeMap[NoticeType.title] = _title;
    noticeMap[NoticeType.description] = _description;
    noticeMap[NoticeType.date] = _date;
    _mapList.add(noticeMap);

    //_curList.add(List.filled(3, [_title, _description, _date]));

    // 가까운 날짜 순서로 정렬 (오름차순)
    _mapList.sort((a, b) => a[NoticeType.date].compareTo(b[NoticeType.date]));
  }

// 알림의 기한이 끝나 현재 알림에서 과거 기록 알림으로 변경
  Future<void> PutPrevNotice() async {
    await Future.delayed(Duration(seconds: 0));
    setState(() {
      final curMap = _mapList[0];
      _mapList.removeAt(0);
      _prevList2.add(curMap);

      // 가까운 날짜 순서로 정렬 (내림차순)
      _prevList2
          .sort(((a, b) => b[NoticeType.date].compareTo(a[NoticeType.date])));

      // 만약, 과거 리스트가 50개가 넘어간다면 가장 마지막을 삭제
      // 유저 친화적이지 않은데... 그렇다고 페이지를 구현하려니 고작 알림리스트에? 싶고
      // 아마 많은 유저가 알림 보관을 많이 할 거라고 생각하진 않음
      // 중요 알림 보관기능이면 몰라도..
      // 아직 충분히 논의된 부분이 아니므로 그냥 둠
      if (_prevList2.length > 50) _prevList2.removeLast();
    });
  }

  // 실제 구현
  @override
  Widget build(BuildContext context) {
    // Scaffold 위젯은 화면에 표현할때 최상단 구조 뼈대 위젯
    // Scaffold 가 없으면 위젯을 그리지 못함
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림 내용 리스트'),
        // leading: 위젯이나 아이콘등을 타이틀 왼쪽에 위치 시키는것
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: '뒤로 가기',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_open),
            onPressed: _pushPrev,
            tooltip: '이전알림',
          ),
        ],
      ),
      body: _buildNotice(),
    );
  }

  // 알림 위젯
  Widget _buildRow(String title, String descript, String dates) {
    return Card(
        margin: EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 0),
        elevation: 8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 25.0,
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              leading: Icon(
                Icons.lock_clock,
                size: 32,
              ),
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 0,
                ),
              ),
              subtitle: Text(
                descript,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.8,
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Text(dates,
                  style: TextStyle(
                    fontSize: 13,
                    height: 0,
                  )),
              SizedBox(
                width: 20.0,
              ),
            ])
          ],
        ));
  }

  // 현재 알림 리스트
  Widget _buildNotice() {
    if (isFirst) {
      GetNotice('11청소 알림', '세종관 318호로', '2022/04/05');
      GetNotice('33청소 알림', '세종관 318호로', '2022/06/05');
      GetNotice('22청소 알림', '세종관 318호로', '2022/05/05');
      GetNotice('55청소 알림', '세종관 318호로', '2022/08/05');
      GetNotice('44청소 알림', '세종관 318호로', '2022/07/05');
      GetNotice('66청소 알림', '세종관 318호로', '2022/09/05');
    }
    return ListView.builder(
        itemCount: _mapList.length,
        itemBuilder: (context, i) {
          return _buildRow(
            _mapList[i][NoticeType.title],
            _mapList[i][NoticeType.description],
            _mapList[i][NoticeType.date],
          );
        });
  }

  // 이전 알림 리스트 버튼
  void _pushPrev() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('이전 알림 리스트'),
            ),
            body: _buildPrevNotice(),
          );
        },
      ),
    );
  }

  // 이전 알림 리스트
  Widget _buildPrevNotice() {
    if (isFirst) {
      PutPrevNotice();
      PutPrevNotice();
      PutPrevNotice();
      isFirst = false;
    }

    return ListView.builder(
        itemCount: _prevList2.length,
        itemBuilder: (context, i) {
          return Dismissible(
            key: Key(_prevList2[i][NoticeType.date]),
            background: Container(
              margin: EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: Icon(Icons.delete, size: 32, color: Colors.white),
            ),
            child: _buildRow(
              _prevList2[i][NoticeType.title],
              _prevList2[i][NoticeType.description],
              _prevList2[i][NoticeType.date],
            ),
            onDismissed: (direction) {
              _prevList2.removeAt(i);
              setState(() {});
            },
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('해당 알림을 삭제할까요?'),
                  content: Text('${_prevList2[i][NoticeType.title]}을 삭제합니다.'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('취소'),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    FlatButton(
                      child: Text('삭제'),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
