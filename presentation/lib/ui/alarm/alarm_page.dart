import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/alarm/alarm_event.dart';
import 'package:presentation/ui/alarm/alarm_list_item.dart';
import 'package:presentation/ui/alarm/alarm_viewmodel.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_tabbar.dart';
import 'package:presentation/constants/asset_path.dart' as asset;
import 'package:provider/provider.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AlarmViewModel(),
      child: _AlarmPage(),
    );
  }
}

class _AlarmPage extends StatefulWidget with ViewModel<AlarmViewModel> {
  const _AlarmPage();

  @override
  State<_AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<_AlarmPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => setEventListener());
    Future.microtask(() => _showProgress());
  }

  void setEventListener() {
    widget.read(context).uiEventStream.listen((event) {
      switch (event) {
        case AlarmEvent.showProgress:
          _showProgress();
        case AlarmEvent.dismissProgress:
          _dismissProgress();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultPage(
      title: "알림",
      action: SvgPicture.asset(asset.setting),
      content: DefaultTabBar(
        overLayColor: Colors.transparent,
        tabAlignment: TabAlignment.center,
        padding: EdgeInsets.only(left: 16, bottom: 16),
        tabLabelPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        indicatorInsets: EdgeInsets.symmetric(horizontal: 8),
        tabs: [
          DefaultTab(
            tabName: "새 알림",
            page: widget.watchWidget(
              (viewModel) => viewModel.newNotificationList,
              (context, list) {
                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 8),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return AlarmListItem(
                      data: list[index],
                      onTap: () => widget
                          .read(context)
                          .updateReadNotification(list[index].id),
                    );
                  },
                );
              },
              shouldRebuild: (previous, next) {
                return previous.length != next.length;
              },
            ),
          ),
          DefaultTab(
            tabName: "읽은 알림",
            page: widget.watchWidget(
              (viewModel) => viewModel.readNotificationList,
              (context, list) {
                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 8),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return AlarmListItem(
                      data: list[index],
                    );
                  },
                );
              },
              shouldRebuild: (previous, next) {
                return previous.length != next.length;
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showProgress() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _dismissProgress() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
