import 'package:flutter/material.dart';

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
    this.bottomPadding = 0.0,
  }) : super(key: key);

  final List<DefaultTab> tabs;
  final double bottomPadding;

  @override
  State<DefaultTabBar> createState() => _DefaultTabBarState();
}

class _DefaultTabBarState extends State<DefaultTabBar> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 상단탭 부분
        Padding(
          padding: EdgeInsets.only(bottom: widget.bottomPadding),
          child: Row(
            children: List.generate(widget.tabs.length, (index) {
              return GestureDetector(
                onTap: () => setState(() => _pageIndex = index),
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
                            style: _pageIndex == index
                                ? theme.tabBarTheme.labelStyle
                                : theme.tabBarTheme.unselectedLabelStyle,
                          ),
                        ),
                        if (_pageIndex == index)
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

        // 탭의 내용부분
        widget.tabs[_pageIndex].page,
      ],
    );
  }
}
