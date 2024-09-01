import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/api_provider/project_provider.dart';
import 'package:p_cube_plus_application/widgets/common/default_futureBuilder.dart';
import 'package:p_cube_plus_application/widgets/common/default_refreshIndicator.dart';
import 'package:p_cube_plus_application/widgets/page/default_content.dart';
import 'package:p_cube_plus_application/widgets/project/project_view.dart';
import 'package:provider/provider.dart';

import '../../widgets/page/default_page.dart';
import '../../widgets/page/default_tabbar.dart';

class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "프로젝트",
      content: DefaultTabBar(
        tabs: [
          DefaultTab(title: "메인", page: _ProjectListView(type: "메인 프로젝트")),
          DefaultTab(title: "꼬꼬마", page: _ProjectListView(type: "꼬꼬마 프로젝트")),
        ],
      ),
    );
  }
}

class _ProjectListView extends StatelessWidget {
  const _ProjectListView({
    Key? key,
    required this.type,
  }) : super(key: key);
  final String type;

  @override
  Widget build(BuildContext context) {
    var projectProvider = context.watch<ProjectProvider>();

    return DefaultContent(
      child: DefaultRefreshIndicator(
        refreshFunction: projectProvider.refresh,
        child: DefaultFutureBuilder(
          fetchData: projectProvider.fetch(),
          showFunction: (data) => Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  projectProvider.getProjectListByType(type).length,
                  (index) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ProjectView(
                            project: projectProvider
                                .getProjectListByType(type)[index]),
                      ),
                  growable: false)),
        ),
      ),
    );
  }
}
