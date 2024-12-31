import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/project/value_objects/project_detail_data.dart';
import 'package:domain/project/value_objects/project_detail_member_data.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/project/project_detail/project_detail_view_model.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_profile.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';
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
      content: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: theme.primary80,
              width: double.infinity,
              height: 160,
            ),
            DefaultFutureBuilder(
              fetchData: read(context).fetchProjectDetail(),
              showOnLoadedWidget:
                  (BuildContext context, ProjectDetailData data) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    ProjectOverviewWidget(data: data),
                    SizedBox(height: 40),
                    ProjectTeamInfoWidget(dataList: data.memberList),
                    SizedBox(height: 32),
                  ],
                );
              },
              showOnLoadingWidget: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: SkeletonAnimation(
                            120,
                            32,
                            radius: 4,
                            subColor: theme.content,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, top: 4, bottom: 20),
                          child: SkeletonAnimation(
                            84,
                            20,
                            radius: 4,
                            subColor: theme.content,
                          ),
                        ),
                        RoundedBorder(
                          width: double.infinity,
                          color: theme.content,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Stack(children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SkeletonAnimation(120, 24, radius: 4),
                                SizedBox(height: 8),
                                SkeletonAnimation(160, 12, radius: 4),
                                SizedBox(height: 16),
                                SkeletonAnimation(180, 16, radius: 4),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: SkeletonAnimation(85, 20, radius: 4),
                            ),
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "팀원 정보",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: theme.neutral40,
                            ),
                          ),
                          SizedBox(height: 8),
                          Column(
                            children: List.generate(
                              3,
                              (index) {
                                return RoundedBorder(
                                  padding: const EdgeInsets.all(16.0),
                                  margin: EdgeInsets.only(bottom: 8),
                                  color: theme.content,
                                  child: Stack(
                                    children: [
                                      Row(
                                        children: [
                                          DefaultProfile(size: 32),
                                          SizedBox(width: 16),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SkeletonAnimation(72, 16,
                                                  radius: 4),
                                              SizedBox(height: 8),
                                              SkeletonAnimation(120, 14,
                                                  radius: 4),
                                            ],
                                          )
                                        ],
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 8,
                                        bottom: 8,
                                        child: SkeletonAnimation(120, 14,
                                            radius: 4),
                                      )
                                    ],
                                  ),
                                );
                              },
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
      ),
    );
  }
}

class ProjectOverviewWidget extends StatelessWidget {
  final ProjectDetailData data;

  const ProjectOverviewWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          padding: const EdgeInsets.only(left: 24, top: 4, bottom: 20),
          child: Text(
            "${data.type}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        RoundedBorder(
          width: double.infinity,
          color: theme.content,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: theme.neutral100,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${data.platformType} / ${data.graphicType}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: theme.neutral40,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        "진행중",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.neutral80,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${data.startDate.format("yyyy.MM.dd")} ~ ${data.endDate?.format("yyyy.MM.dd") ?? ""}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: theme.neutral80,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Builder(builder: (context) {
                  if (data.isFindingMember) {
                    return Text(
                      "팀원 모집 중",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: theme.primary80,
                      ),
                    );
                  } else {
                    return Text(
                      "팀원 모집 마감",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: theme.neutral40,
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProjectTeamInfoWidget extends StatelessWidget {
  final List<ProjectDetailMemberData> dataList;

  const ProjectTeamInfoWidget({super.key, required this.dataList});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "팀원 정보",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: theme.neutral40,
            ),
          ),
          SizedBox(height: 8),
          Column(
            children: List.generate(dataList.length, (index) {
              return RoundedBorder(
                padding: const EdgeInsets.all(16.0),
                margin: EdgeInsets.only(bottom: 8),
                color: theme.content,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        DefaultProfile(size: 32),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataList[index].name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: theme.neutral80,
                              ),
                            ),
                            Text(
                              "${dataList[index].memberPartType} 파트",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: theme.neutral40,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Row(
                        children: List.generate(
                            dataList[index].projectRoleTags.length,
                            (roleIndex) {
                          final tag =
                              dataList[index].projectRoleTags[roleIndex];
                          if (tag.isProjectLead) {
                            return RoundedBorder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              margin: EdgeInsets.only(left: 4),
                              radius: 50,
                              color: theme.primary80,
                              hasShadow: false,
                              child: Text(
                                dataList[index].projectRoleTags[roleIndex].role,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          } else {
                            return RoundedBorder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              margin: EdgeInsets.only(left: 4),
                              radius: 50,
                              color: theme.neutral5,
                              hasShadow: false,
                              child: Text(
                                dataList[index].projectRoleTags[roleIndex].role,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: theme.neutral60,
                                ),
                              ),
                            );
                          }
                        }),
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
