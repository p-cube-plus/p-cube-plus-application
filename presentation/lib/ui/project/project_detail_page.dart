import 'package:domain/project/value_objects/project_detail_data.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/project/project_detail_view_model.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:provider/provider.dart';

class ProjectDetailPage extends StatelessWidget {
  final int projectId;

  const ProjectDetailPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProjectDetailViewModel(projectId),
      child: _ProjectDetailPage(),
    );
  }
}

class _ProjectDetailPage extends StatelessWidget
    with ViewModel<ProjectDetailViewModel> {
  const _ProjectDetailPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: "프로젝트 정보",
        backgroundColor: theme.primary80,
        contentColor: Colors.white,
      ),
      bottomPadding: 0,
      content: Stack(
        children: [
          Container(
            color: theme.primary80,
            width: double.infinity,
            height: 160,
          ),
          DefaultFutureBuilder(
            fetchData: read(context).fetchProjectDetail(),
            showOnLoadedWidget: (BuildContext context, ProjectDetailData data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      data.title,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      "${data.type}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  RoundedBorder(
                    width: double.infinity,
                    color: theme.content,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "123",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: theme.neutral100,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "123",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: theme.neutral100,
                          ),
                        ),
                        Text(
                          "123", //"진행중 ${data[index].startDate.format("yyyy.MM.dd")} ~ ${data[index].endDate?.format("yyyy.MM.dd") ?? ""}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: theme.neutral100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
