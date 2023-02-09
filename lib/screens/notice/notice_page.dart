import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/default_page_widget.dart';
import 'package:p_cube_plus_application/widgets/notice_box_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../../models/notification_node.dart';
import '../../widgets/tabbar/custom_tab_bar._widget.dart';
import '../settings/setting_notice_page.dart';

Future<List<NotificationNode>> fetchNotification() async {
  final url = Uri.parse('http://p-cube-plus.com/user/notification');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print(json.decode(response.body).runtimeType);
    return (json.decode(response.body) as List)
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

class _NoticePageState extends State<NoticePage> with TickerProviderStateMixin {
  Future<List<NotificationNode>>? notificationAPI;

  @override
  void initState() {
    super.initState();
    notificationAPI = fetchNotification();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appBarTitle: "알림",
      appBarActions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingNoticePage(),
              ),
            );
          },
          child: Icon(
            Icons.settings,
            color: Theme.of(context).textTheme.headline2!.color,
          ),
        ),
      ],
      content: CustomTabBar(
        tabs: ["새 알림", "읽은 알림"],
        pages: [
          NoticeListView(
            isNew: true,
            notificationAPI: notificationAPI,
          ),
          NoticeListView(
            isNew: false,
            notificationAPI: notificationAPI,
          ),
        ],
      ),
      scrollable: false,
    );
  }
}

class NoticeListView extends StatelessWidget {
  const NoticeListView({
    Key? key,
    required this.isNew,
    required this.notificationAPI,
  }) : super(key: key);

  final Future<List<NotificationNode>>? notificationAPI;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NotificationNode>>(
      future: notificationAPI,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: List.generate(
              snapshot.data!.length,
              (index) =>
                  NoticeBoxWidget(isNew: isNew, box: snapshot.data![index]),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("정보를 불러올 수 없습니다."));
        }

        // 기본적으로 로딩 Spinner를 보여줍니다.
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
