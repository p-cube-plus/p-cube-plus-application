import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/project/project_event.dart';
import 'package:presentation/ui/project/project_tab.dart';
import 'package:presentation/ui/project/project_view_model.dart';
import 'package:presentation/ui/skeleton/skeleton_project.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_refresh_indicator.dart';
import 'package:presentation/widgets/default_tabbar.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProjectViewModel(),
      child: _ProjectPage(),
    );
  }
}

class _ProjectPage extends StatefulWidget {
  const _ProjectPage();

  @override
  State<_ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<_ProjectPage>
    with AutomaticKeepAliveClientMixin, ViewModel<ProjectViewModel> {
  var _refreshKey = UniqueKey();
  var _pageIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _setEventListener());
  }

  void _setEventListener() {
    read(context).eventStream.listen((event) {
      switch (event) {
        case ProjectEvent.showDataErrorToast:
          _showDataErrorToast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultPage(
      title: "프로젝트",
      content: DefaultTabBar(
        key: _refreshKey,
        overLayColor: Colors.transparent,
        padding: EdgeInsets.only(left: 16, bottom: 8),
        tabLabelPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        indicatorInsets: EdgeInsets.symmetric(horizontal: 4),
        pageIndex: _pageIndex,
        onChangeTab: (tabIndex) => _pageIndex = tabIndex,
        tabs: [
          DefaultTab(
            tabName: "메인",
            page: DefaultFutureBuilder(
              fetchData: read(context).fetchMainProject(),
              showOnLoadedWidget: (context, data) {
                return DefaultRefreshIndicator(
                  onRefresh: () async => setState(
                    () => _refreshKey = UniqueKey(),
                  ),
                  child: ProjectTab(data: data),
                );
              },
              showOnLoadingWidget: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: SkeletonProject(),
                );
              },
            ),
          ),
          DefaultTab(
            tabName: "꼬꼬마",
            page: DefaultFutureBuilder(
              fetchData: read(context).fetchTraineeProject(),
              showOnLoadedWidget: (context, data) {
                return DefaultRefreshIndicator(
                  onRefresh: () async => setState(
                    () => _refreshKey = UniqueKey(),
                  ),
                  child: ProjectTab(data: data),
                );
              },
              showOnLoadingWidget: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: SkeletonProject(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDataErrorToast() {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: "프로젝트 불러오기에 실패했습니다!\n새로고침해주세요.");
  }
}
