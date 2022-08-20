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
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(widget.tabs.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () => setState(() => _pageIndex = index),
                    child: Container(
                      height: 28.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: index > 0 ? 16.0 : 0,
                            ),
                            child: Text(
                              widget.tabs[index],
                              style: _pageIndex == index
                                  ? Theme.of(context).tabBarTheme.labelStyle
                                  : Theme.of(context)
                                      .tabBarTheme
                                      .unselectedLabelStyle,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          if (_pageIndex == index)
                            SizedBox(
                              width: 28.0,
                              height: 2.0,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .tabBarTheme
                                        .labelColor),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 12.0),
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
                /*
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
                */
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text("메롱");
        }

        // 기본적으로 로딩 Spinner를 보여줍니다.
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
