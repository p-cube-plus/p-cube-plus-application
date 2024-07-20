import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/api_provider/user_project_provider.dart';
import 'package:p_cube_plus_application/widgets/common/default_futureBuilder.dart';
import 'package:p_cube_plus_application/widgets/common/default_refreshIndicator.dart';
import 'package:provider/provider.dart';
import '../../remote_f/models/project_dto.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';
import '../../widgets/project/project_view.dart';

class ProjectListPage extends StatelessWidget {
  const ProjectListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var projectProvider = context.watch<UserProjectListProvider>();

    return DefaultRefreshIndicator(
      refreshFunction: projectProvider.refresh,
      child: DefaultFutureBuilder(
        fetchData: projectProvider.fetch(),
        showFunction: (List<ProjectDTO> projects) => DefaultPage(
          title: "참여 프로젝트",
          appbar: DefaultAppBar(),
          content: (projects.length == 0)
              ? Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "참여한 프로젝트가 없습니다.",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                )
              : DefaultContent(child: ProjectListView(projects: projects)),
        ),
      ),
    );
  }
}

class ProjectListView extends StatelessWidget {
  const ProjectListView({
    Key? key,
    required this.projects,
  }) : super(key: key);

  final List<ProjectDTO> projects;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        projects.length,
        (index) {
          ProjectDTO project = projects[index];

          return Padding(
            padding: EdgeInsets.only(top: index == 0 ? 0.0 : 16.0),
            child: ProjectView(project: project),
          );
        },
      ),
    );
  }
}
