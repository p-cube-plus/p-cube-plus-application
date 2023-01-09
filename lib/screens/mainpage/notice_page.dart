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
    var product = Provider.of<NoticeProvider>(context);

    return DefaultPage(
      appBarTitle: "알림",
      appBarActions: [
        PopupMenuButton(
          tooltip: "정렬기준",
          icon: Icon(
            Icons.settings,
            color: Theme.of(context).textTheme.headline2!.color,
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
      content: NoticeTabBar(
        tabs: ["새 알림", "읽은 알림"],
        pages: [
          NoticeListView(
            notificationAPI: notificationAPI,
          ),
          Container(),
        ],
      ),
      scrollable: false,
    );
  }
}

class NoticeTabBar extends StatefulWidget {
  const NoticeTabBar({
    Key? key,
    required this.tabs,
    required this.pages,
  }) : super(key: key);
  final List<String> tabs;
  final List<Widget> pages;

  @override
  State<NoticeTabBar> createState() => _NoticeTabBarState();
}

class _NoticeTabBarState extends State<NoticeTabBar> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(widget.tabs.length, (index) {
                return GestureDetector(
                  onTap: () => setState(() => _pageIndex = index),
                  child: Row(
                    children: [
                      Container(
                        height: 28.0,
                        color: _pageIndex == index
                            ? Theme.of(context).tabBarTheme.labelColor
                            : Theme.of(context).backgroundColor,
                        child: Column(
                          children: [
                            Container(
                              color: Theme.of(context).backgroundColor,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 4, left: 4, right: 4, bottom: 2),
                                child: Text(
                                  widget.tabs[index],
                                  style: _pageIndex == index
                                      ? Theme.of(context).tabBarTheme.labelStyle
                                      : Theme.of(context)
                                          .tabBarTheme
                                          .unselectedLabelStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20)
                    ],
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 16.0),
          SingleChildScrollView(
            child: widget.pages[_pageIndex],
          ),
        ],
      ),
    );
  }
}

class NoticeListView extends StatelessWidget {
  const NoticeListView({
    Key? key,
    required this.notificationAPI,
  }) : super(key: key);

  final Future<List<NotificationNode>>? notificationAPI;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NotificationNode>>(
      future: notificationAPI,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: List.generate(
              snapshot.data!.length,
              (index) {
                return NoticeBoxWidget(snapshot.data![index]);
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text("정보를 불러올 수 없습니다.");
        }

        // 기본적으로 로딩 Spinner를 보여줍니다.
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
