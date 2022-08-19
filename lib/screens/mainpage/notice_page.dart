import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/notice_provider.dart';
import 'package:p_cube_plus_application/widgets/default_page_widget.dart';
import 'package:p_cube_plus_application/widgets/notice_box_widget.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../../models/notification_node.dart';

Future<List<NotificationNode>> fetchNotification() async {
  final url = Uri.parse('http://p-cube-plus.com/user/notification');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print(json.decode(response.body).runtimeType);
    return (json.decode(response.body)['notification_list'] as List)
        .map((data) => NotificationNode.fromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load post');
  }
}

class NoticePage extends StatefulWidget {
  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  Future<List<NotificationNode>>? notificationAPI;

  @override
  void initState() {
    super.initState();
    notificationAPI = fetchNotification();
  }

  @override
  Widget build(BuildContext context) {
    var product = Provider.of<NoticeProvider>(context);

    return DefaultPage(
      appBarTitle: "알림",
      appBarActions: [
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
          ],
        ),
      ],
      content: FutureBuilder<List<NotificationNode>>(
        future: notificationAPI,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: List.generate(
                snapshot.data!.length,
                (index) {
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      margin: EdgeInsets.only(
                          left: 0, top: 12, right: 0, bottom: 0),
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
                          Icon(Icons.delete_outlined,
                              size: 32, color: Colors.white),
                        ],
                      ),
                    ),
                    child: NoticeBoxWidget(snapshot.data![index]),
                    onDismissed: (direction) {
                      product.deleteNotice(index);
                    },
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text("메롱");
          }

          // 기본적으로 로딩 Spinner를 보여줍니다.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
