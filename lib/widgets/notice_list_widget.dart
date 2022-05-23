import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/notice_box.dart';
import '../providers/notice_list.dart';
import '../widgets/notice_box_widget.dart';

class NoticeListWidget extends StatefulWidget {
  const NoticeListWidget({Key? key}) : super(key: key);

  @override
  State<NoticeListWidget> createState() => _NoticeListWidgetState();
}

class _NoticeListWidgetState extends State<NoticeListWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<NoticeList>(context);

    if (product.isFirst) {
      product.getNotice(
          new NoticeBox('청소 알림', '당일 hh시에 동아리방 청소가 시작됩니다.', '12:00'));
      product.getNotice(new NoticeBox('회비 알림', '당일 hh시에 어쩌구저쩌구', '12:00'));
      product.getNotice(new NoticeBox('도서 반납 알림', '당일 hh시에 어쩌구저쩌구', '12:00'));
      product.getNotice(new NoticeBox('회의 알림', '당일 hh시에 어쩌구저쩌구', '12:00'));
      product.isFirst = false;
    }

    return ListView.builder(
        itemCount: product.curList.length,
        itemBuilder: (context, i) {
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              margin: EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "삭제 ",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Icon(Icons.delete_outlined, size: 32, color: Colors.white),
                ],
              ),
            ),
            child: NoticeBoxWidget(product.curList[i]),
            onDismissed: (direction) {
              product.deleteNotice(i);
            },
            //confirmDismiss: (direction) async {
            //  return await showDialog(
            //    context: context,
            //    builder: (ctx) => AlertDialog(
            //      title: const Text('해당 알림을 삭제할까요?'),
            //      content: Text('${product.prevList[i].title}을 삭제합니다.'),
            //      actions: <Widget>[
            //        TextButton(
            //          child: Text('취소'),
            //          onPressed: () => Navigator.of(context).pop(false),
            //        ),
            //        TextButton(
            //          child: Text('삭제'),
            //          onPressed: () => Navigator.of(context).pop(true),
            //        ),
            //      ],
            //    ),
            //  );
            //},
          );
        });
  }
}
