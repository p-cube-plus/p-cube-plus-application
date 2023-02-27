import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/project_provider.dart';
import 'package:p_cube_plus_application/widgets/project_view_widget.dart';
import 'package:provider/provider.dart';

import '../../models/project.dart';
import '../../widgets/default/default_page_widget.dart';
import '../../widgets/default/default_tabbar_widget.dart';
import '../notice/notice_page.dart';

class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "프로젝트",
      bottomPadding: 24.0,
      content: DefaultTabBar(bottomPadding: 20.0, tabs: [
        DefaultTab(title: "메인", page: _ProjectListView(type: 0)),
        DefaultTab(title: "꼬꼬마", page: _ProjectListView(type: 1)),
      ]),
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
