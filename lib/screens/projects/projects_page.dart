import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/project_provider.dart';
import 'package:p_cube_plus_application/widgets/project_view_widget.dart';
import 'package:provider/provider.dart';

import '../../models/project.dart';
import '../../widgets/default_page_widget.dart';
import '../../widgets/tabbar/custom_tab_bar._widget.dart';
import '../mainpage/notice_page.dart';

class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProjectProvider>(
            create: (_) => ProjectProvider()),
      ],
      child: DefaultPage(
        appBarTitle: "프로젝트",
        content: CustomTabBar(
          tabs: ["메인", "꼬꼬마"],
          pages: [
            _ProjectListView(type: 0), // type 0 - 메인 프로젝트
            _ProjectListView(type: 1), // type 1 - 꼬꼬마 프로젝트
          ],
        ),
        scrollable: false,
      ),
    );
  }
}

class _ProjectListView extends StatelessWidget {
  const _ProjectListView({
    Key? key,
    required this.type,
  }) : super(key: key);
  final int type;

  @override
  Widget build(BuildContext context) {
    var projectProvider = context.watch<ProjectProvider>();
    //projectProvider.update(); // debug

    if (!projectProvider.loaded) return Container();
    if (projectProvider.fail) return Container();

    var projects =
        projectProvider.projectList!.where((e) => e.type == type).toList();

    return Column(
      children: List.generate(projects.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ProjectView(project: projects[index]),
        );
      }),
    );
  }
}
