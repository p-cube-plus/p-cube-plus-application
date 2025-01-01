import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/alarm/alarm_event.dart';
import 'package:presentation/ui/alarm/alarm_list_item.dart';
import 'package:presentation/ui/alarm/alarm_viewmodel.dart';
import 'package:presentation/ui/user/user_setting/user_alarm/user_alarm_page.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_refresh_indicator.dart';
import 'package:presentation/widgets/default_tabbar.dart';
import 'package:presentation/constants/asset_path.dart' as asset;
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';
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

class _AlarmPage extends StatefulWidget {
  const _AlarmPage();

  @override
  State<_AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<_AlarmPage>
    with AutomaticKeepAliveClientMixin, ViewModel<AlarmViewModel> {
  var pageIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _setEventListener());
    Future.microtask(() => _fetchNotificationList());
  }

  void _setEventListener() {
    read(context).eventStream.listen((event) {
      switch (event) {
        case AlarmEvent.showProgress:
          _showProgress();
        case AlarmEvent.dismissProgress:
          _dismissProgress();
        case AlarmEvent.showErrorToast:
          _showErrorToast();
        case AlarmEvent.showDataErrorToast:
          _showDataErrorToast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultPage(
      title: "알림",
      action: GestureDetector(
        onTap: () => _navigateToUserAlarmSettingPage(context),
        child: SvgPicture.asset(asset.setting),
      ),
      content: DefaultTabBar(
        overLayColor: Colors.transparent,
        tabAlignment: TabAlignment.center,
        padding: EdgeInsets.only(left: 16, bottom: 16),
        tabLabelPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        indicatorInsets: EdgeInsets.symmetric(horizontal: 8),
        pageIndex: pageIndex,
        onChangeTab: (newIndex) => pageIndex = newIndex,
        tabs: [
          DefaultTab(
            tabName: "새 알림",
            page: watchWidget(
              (viewModel) => viewModel.isLoading,
              (context, isLoading) {
                if (isLoading) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(3, (index) {
                        return RoundedBorder(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SkeletonAnimation(80, 14, radius: 50),
                                  SizedBox(height: 4),
                                  SkeletonAnimation(160, 14, radius: 50),
                                ],
                              ),
                              SkeletonAnimation(80, 12, radius: 50),
                            ],
                          ),
                        );
                      }),
                    ),
                  );
                }
                return DefaultRefreshIndicator(
                  onRefresh: () async => _fetchNotificationList(),
                  child: watchWidget(
                    (viewModel) => viewModel.newNotificationList,
                    (context, list) {
                      return ListView.builder(
                        padding: EdgeInsets.only(bottom: 8),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return AlarmListItem(
                            data: list[index],
                            onTap: () => read(context)
                                .updateReadNotification(list[index].id),
                          );
                        },
                      );
                    },
                    shouldRebuild: (previous, next) {
                      return previous.length != next.length;
                    },
                  ),
                );
              },
            ),
          ),
          DefaultTab(
            tabName: "읽은 알림",
            page: watchWidget(
              (viewModel) => viewModel.isLoading,
              (context, isLoading) {
                if (isLoading) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(3, (index) {
                        return RoundedBorder(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.only(top: 8),
                          color: Theme.of(context).disabled,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SkeletonAnimation(80, 14, radius: 50),
                                  SizedBox(height: 4),
                                  SkeletonAnimation(160, 14, radius: 50),
                                ],
                              ),
                              SkeletonAnimation(80, 12, radius: 50),
                            ],
                          ),
                        );
                      }),
                    ),
                  );
                }
                return DefaultRefreshIndicator(
                  onRefresh: () async => _fetchNotificationList(),
                  child: watchWidget(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _fetchNotificationList() {
    read(context).fetchNotificationList();
  }

  void _showProgress() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
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

  void _navigateToUserAlarmSettingPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => UserAlarmPage()));
  }

  void _showErrorToast() {
    Fluttertoast.showToast(msg: "알림 읽기에 실패했습니다!\n다시 시도해주세요.");
  }

  void _showDataErrorToast() {
    Fluttertoast.showToast(msg: "알림 불러오기에 실패했습니다!\n새로고침해주세요.");
  }
}
