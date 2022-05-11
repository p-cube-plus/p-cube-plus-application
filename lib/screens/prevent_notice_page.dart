import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/notice_box.dart';
import '../providers/notice_list.dart';

class PrevNoticePage extends StatefulWidget {
  const PrevNoticePage({Key? key}) : super(key: key);

  @override
  State<PrevNoticePage> createState() => _PrevNoticePageState();
}

class _PrevNoticePageState extends State<PrevNoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이전 알림 리스트'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: '뒤로 가기',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildPrevNotice(),
    );
  }

  // 이전 알림 리스트
  Widget _buildPrevNotice() {
    final product = Provider.of<NoticeList>(context);
    final pl = product.prevList;
    if (product.isFirst) {
      product.putPrevNotice();
      product.putPrevNotice();
      product.putPrevNotice();
      product.isFirst = false;
    }

    return ListView.builder(
        itemCount: product.prevList.length,
        itemBuilder: (context, i) {
          return Dismissible(
            key: Key(pl[i][2]),
            background: Container(
              margin: EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: Icon(Icons.delete, size: 32, color: Colors.white),
            ),
            child: makeNoticeBox(
              pl[i][product.title],
              pl[i][product.description],
              pl[i][product.date],
            ),
            onDismissed: (direction) {
              setState(() => product.deletePrevNotice(i));
            },
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('해당 알림을 삭제할까요?'),
                  content: Text('${pl[i][product.title]}을 삭제합니다.'),
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
