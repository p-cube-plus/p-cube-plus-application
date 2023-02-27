import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/default/default_page.dart';
import 'package:p_cube_plus_application/widgets/notice_box_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../../models/notification_node.dart';
import '../../widgets/default/default_tabbar.dart';
import '../settings/setting_notice_page.dart';

Future<List<NotificationNode>> fetchNotification() async {
  final url = Uri.parse('http://p-cube-plus.com/user/notification');
  final response = await http.get(url);

  if (response.statusCode == 200) {
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
      title: "알림",
      bottomPadding: 20.0,
      action: GestureDetector(
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
      content: DefaultTabBar(bottomPadding: 20.0, tabs: [
        DefaultTab(
            title: "새 알림",
            page: NoticeListView(
              isNew: true,
              notificationAPI: notificationAPI,
            )),
        DefaultTab(
            title: "읽은 알림",
            page: NoticeListView(
              isNew: false,
              notificationAPI: notificationAPI,
            )),
      ]),
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
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: NoticeBoxWidget(isNew: isNew, box: snapshot.data![index]),
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
