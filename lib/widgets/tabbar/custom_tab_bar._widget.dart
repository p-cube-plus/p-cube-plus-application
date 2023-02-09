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
          Row(
            children: List.generate(widget.tabs.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
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
                              widget.tabs[index],
                              style: _pageIndex == index
                                  ? Theme.of(context).tabBarTheme.labelStyle
                                  : Theme.of(context)
                                      .tabBarTheme
                                      .unselectedLabelStyle,
                            ),
                          ),
                          if (_pageIndex == index)
                            Expanded(
                              child: Container(
                                color: Theme.of(context).tabBarTheme.labelColor,
                                child: Text(
                                  widget.tabs[index] + " ",
                                  style:
                                      Theme.of(context).tabBarTheme.labelStyle,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 12.0),
          widget.pages[_pageIndex],
        ],
      ),
    );
  }
}
