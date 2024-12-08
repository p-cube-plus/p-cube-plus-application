import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/project/project_tab.dart';
import 'package:presentation/ui/project/project_view_model.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
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
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultPage(
      title: "프로젝트",
      content: DefaultTabBar(
        overLayColor: Colors.transparent,
        padding: EdgeInsets.only(left: 16, bottom: 8),
        tabLabelPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        indicatorInsets: EdgeInsets.symmetric(horizontal: 4),
        tabs: [
          DefaultTab(
            tabName: "메인",
            page: DefaultFutureBuilder(
              fetchData: read(context).fetchMainProject(),
              showOnLoadedWidget: (context, data) {
                return ProjectTab(data: data);
              },
            ),
          ),
          DefaultTab(
            tabName: "꼬꼬마",
            page: DefaultFutureBuilder(
              fetchData: read(context).fetchTraineeProject(),
              showOnLoadedWidget: (context, data) {
                return ProjectTab(data: data);
              },
            ),
          ),
        ],
      ),
    );
  }
}
