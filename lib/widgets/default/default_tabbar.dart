import 'package:flutter/material.dart';

import 'default_content.dart';

class DefaultTab {
  DefaultTab({
    required this.title,
    required this.page,
  });
  final String title;
  final Widget page;
}

class DefaultTabBar extends StatefulWidget {
  const DefaultTabBar({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  final List<DefaultTab> tabs;

  @override
  State<DefaultTabBar> createState() => _DefaultTabBarState();
}

class _DefaultTabBarState extends State<DefaultTabBar> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double startX = 0.0;
    double endX = 0.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 상단탭 부분
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 12.0),
          child: Row(
            children: List.generate(widget.tabs.length, (index) {
              return GestureDetector(
                onTap: () => setState(() => pageIndex = index),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: index > 0 ? 16.0 : 0,
                  ),
                  child: Container(
                    height: 28.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 4, right: 4, top: 4, bottom: 2),
                          child: Text(
                            widget.tabs[index].title,
                            style: pageIndex == index
                                ? theme.tabBarTheme.labelStyle
                                : theme.tabBarTheme.unselectedLabelStyle,
                          ),
                        ),
                        if (pageIndex == index)
                          Expanded(
                            child: Container(
                              color: theme.tabBarTheme.labelColor,
                              child: Text(
                                widget.tabs[index].title + "   ",
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        // 내용부분
        Expanded(
            child: GestureDetector(
          onHorizontalDragStart: (details) =>
              startX = details.globalPosition.dx,
          onHorizontalDragUpdate: (details) {
            endX = details.localPosition.dx;
          },
          onHorizontalDragEnd: (details) {
            setState(() {
              if (endX - startX > 50.0)
                --pageIndex;
              else if (startX - endX > 50.0) ++pageIndex;
              if (pageIndex < 0)
                pageIndex = widget.tabs.length - 1;
              else if (pageIndex >= widget.tabs.length) pageIndex = 0;
            });
          },
          child: DefaultContent(child: widget.tabs[pageIndex].page),
        )),
      ],
    );
  }
}
