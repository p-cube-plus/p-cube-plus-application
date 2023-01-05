import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    Key? key,
    required this.tabs,
    required this.pages,
  }) : super(key: key);
  final List<String> tabs;
  final List<Widget> pages;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
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
