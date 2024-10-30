import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class DefaultTab {
  final String tabName;
  final Widget page;
  DefaultTab({
    required this.tabName,
    required this.page,
  });
}

class DefaultTabBar extends StatefulWidget {
  const DefaultTabBar({
    super.key,
    required this.tabs,
    this.pageIndex = 0,
    this.tabAlignment = TabAlignment.center,
    this.padding,
    this.tabLabelPadding,
  });

  final List<DefaultTab> tabs;
  final int pageIndex;
  final TabAlignment tabAlignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? tabLabelPadding;

  @override
  State<DefaultTabBar> createState() => _DefaultTabBarState();
}

class _DefaultTabBarState extends State<DefaultTabBar>
    with TickerProviderStateMixin {
  late TabController controller;
  late List<Widget> tabList;
  late List<Widget> pageList;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.pageIndex,
    );

    tabList = widget.tabs.map((tab) => Text(tab.tabName)).toList();
    pageList = widget.tabs.map((tab) => tab.page).toList();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          tabAlignment: widget.tabAlignment,
          dividerHeight: 0,
          isScrollable: false,
          controller: controller,
          padding: widget.padding,
          labelPadding: widget.tabLabelPadding,
          tabs: tabList,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2.0,
              color: theme.neutral100,
            ),
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: theme.neutral20,
          ),
          labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: theme.neutral100,
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: const PageScrollPhysics(),
            controller: controller,
            children: pageList,
          ),
        ),
      ],
    );
  }
}
