import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/notice_provider.dart';
import 'package:p_cube_plus_application/widgets/notice_box_widget.dart';
import 'package:provider/provider.dart';

import '../../models/notice_box.dart';

class NoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<NoticeProvider>(context);

    if (product.isFirst) {
      product.getNotice(new NoticeBox('청소 알림', '당일 hh시에 청소가 시작됩니다.', '1:00'));
      product.getNotice(new NoticeBox('회비 알림', '당일 hh시에 어쩌구저쩌구', '2:00'));
      product.getNotice(new NoticeBox('도서 반납 알림', '당일 hh시에 어쩌구저쩌구', '4:00'));
      product.getNotice(new NoticeBox('회의 알림', '당일 hh시에 어쩌구저쩌구', '3:00'));
      product.isFirst = false;
    }

    return Scaffold(
      appBar: AppBar(title: Text('알림'), automaticallyImplyLeading: false,
          //leading: IconButton(
          //  icon: const Icon(Icons.arrow_back),
          //  color: Color.fromARGB(255, 0, 0, 0),
          //  tooltip: '뒤로 가기',
          //  onPressed: () {
          //    Navigator.pop(context);
          //  },
          //),
          actions: [
            PopupMenuButton(
                tooltip: "정렬기준",
                icon: const Icon(
                  Icons.more_vert,
                ),
                elevation: 30,
                onSelected: (SortType value) {
                  product.changeSortType(value);
                },
                itemBuilder: (context) => [
                      const PopupMenuItem(
                        child: Text(
                          "오름차순",
                        ),
                        value: SortType.Ascending,
                      ),
                      const PopupMenuItem(
                        child: Text(
                          "내림차순",
                        ),
                        value: SortType.Descending,
                      ),
                    ])
          ]),
      body: ListView.builder(
          itemCount: product.curList.length,
          itemBuilder: (context, i) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                margin: EdgeInsets.only(left: 0, top: 12, right: 0, bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Color(0xFFDE2B13),
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
            );
          }),
    );
  }
}
