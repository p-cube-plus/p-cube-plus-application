import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/notice_box.dart';
import '../providers/notice_list.dart';

import 'prevent_notice_page.dart';

// 알림은 앱 실행 도중 변경 가능한 위젯
class CurNoticePage extends StatefulWidget {
  const CurNoticePage({Key? key}) : super(key: key);

  @override
  State<CurNoticePage> createState() => _CurNoticePageState();
}

class _CurNoticePageState extends State<CurNoticePage> {
  @override
  Widget build(BuildContext context) {
    // Scaffold 위젯은 화면에 표현할때 최상단 구조 뼈대 위젯
    // Scaffold 가 없으면 위젯을 그리지 못함
    return Scaffold(
      appBar: AppBar(
        title: const Text('현재 알림 리스트'),
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
            onPressed: () => _pushPrev(),
            tooltip: '이전알림',
          ),
        ],
      ),
      body: _buildNotice(),
    );
  }

  // 이전 알림 리스트 버튼
  void _pushPrev() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PrevNoticePage()),
    ).then((value) => setState(() {}));
  }

  // 현재 알림 리스트
  Widget _buildNotice() {
    final product = Provider.of<NoticeList>(context);
    final cl = product.curList;

    if (product.isFirst) {
      product.getNotice('11청소 알림', '세종관 318호로', '2022/04/05');
      product.getNotice('33청소 알림', '세종관 318호로', '2022/06/05');
      product.getNotice('22청소 알림', '세종관 318호로', '2022/05/05');
      product.getNotice('55청소 알림', '세종관 318호로', '2022/08/05');
      product.getNotice('44청소 알림', '세종관 318호로', '2022/07/05');
      product.getNotice('66청소 알림', '세종관 318호로', '2022/09/05');
    }

    return ListView.builder(
        itemCount: product.curList.length,
        itemBuilder: (context, i) {
          return makeNoticeBox(
            cl[i][product.title],
            cl[i][product.description],
            cl[i][product.date],
          );
        });
  }
}
