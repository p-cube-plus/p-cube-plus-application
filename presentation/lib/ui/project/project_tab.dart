import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/project/value_objects/project_data.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/project/project_detail/project_detail_page.dart';
import 'package:presentation/ui/project/project_view_model.dart';
import 'package:presentation/widgets/default_profile_list.dart';
import 'package:presentation/widgets/rounded_border.dart';

class ProjectTab extends StatelessWidget with ViewModel<ProjectViewModel> {
  const ProjectTab({
    super.key,
    required this.data,
  });

  final List<ProjectData> data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.builder(
      itemCount: data.length,
      padding: EdgeInsets.symmetric(vertical: 12),
      itemBuilder: (context, index) {
        return RoundedBorder(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 8),
          padding: EdgeInsets.all(20),
          color: data[index].isFinishedProject ? theme.disabled : theme.content,
          onTap: () => _navigateToProjectDetailPage(
            context,
            data[index].projectId,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data[index].title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: data[index].isFinishedProject
                          ? theme.neutral40
                          : theme.neutral100,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "${data[index].type}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: data[index].isFinishedProject
                          ? theme.neutral40
                          : theme.neutral100,
                    ),
                  ),
                  Text(
                    "진행중 ${data[index].startDate.format("yyyy.MM.dd")} ~ ${data[index].endDate?.format("yyyy.MM.dd") ?? ""}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: data[index].isFinishedProject
                          ? theme.neutral40
                          : theme.neutral100,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: DefaultProfileList(
                  itemCount: data[index].memberCount,
                  size: 24,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Builder(
                  builder: (context) {
                    if (data[index].isFinishedProject) {
                      return SizedBox();
                    }
                    if (data[index].isFindingMember) {
                      return Text(
                        "팀원 모집 중",
                        style: TextStyle(
                          color: theme.primary80,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    } else {
                      return Text(
                        "팀원 모집 마감",
                        style: TextStyle(
                          color: theme.neutral40,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _navigateToProjectDetailPage(
    BuildContext context,
    int projectId,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProjectDetailPage(projectId: projectId),
      ),
    );
  }
}
