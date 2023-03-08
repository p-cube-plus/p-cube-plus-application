import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/widgets/default/default_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../../models/notification_node.dart';
import '../../widgets/default/default_tabbar.dart';
import '../../widgets/default/rounded_border.dart';
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
      content: DefaultTabBar(tabs: [
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
          return Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  snapshot.data!.length,
                  (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: NoticeBoxWidget(
                          isNew: isNew, box: snapshot.data![index]))));
        } else if (snapshot.hasError) {
          return Center(child: Text("정보를 불러올 수 없습니다."));
        }

        // 기본적으로 로딩 Spinner를 보여줍니다.
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class NoticeBoxWidget extends StatelessWidget {
  const NoticeBoxWidget({required this.isNew, required this.box});

  final NotificationNode box;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      onTap: () {},
      hasShadow: true,
      color: isNew
          ? Theme.of(context).bottomNavigationBarTheme.backgroundColor
          : Theme.of(context).disabledColor,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    box.name,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(width: 4.0),
                  if (isNew)
                    Container(
                      height: 4.0,
                      width: 4.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFDE2B13)),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                box.description,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
          Text(
            DateFormat("hh:mm").format(DateTime.parse(box.date)),
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}
