import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/widgets/rounded_border_widget.dart';
import '../../models/member.dart';
import '../../models/project.dart';
import '../../widgets/default_page_widget.dart';
import '../../widgets/default_profile.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({
    Key? key,
    required this.project,
  }) : super(key: key);
  final Project project;

  @override
  Widget build(BuildContext context) {
    var projectName = project.name;
    var projectType = "${["메인", "꼬꼬마"][project.type]}프로젝트";
    var projectProperty = project.platforms.join(", ");
    if (project.tags.length > 0)
      projectProperty += " / " + project.tags.join(", ");

    var projectDate = "";
    if (project.startDate != null)
      projectDate = "${DateFormat('yyyy.MM.dd').format(project.startDate!)} ~ ";
    if (project.isEnd && project.endDate != null)
      projectDate += DateFormat('yyyy.MM.dd').format(project.endDate!);

    return DefaultPage(
      scrollable: false,
      backgroundColor: const Color(0xC9DE2B13),
      appBarHasPrevious: true,
      appBarTitle: projectName,
      appBarTitleColor: Colors.white,
      appBarPadding: const EdgeInsets.only(top: 40, bottom: 4),
      subtitle: "프로젝트 정보",
      subtitleColor: Colors.white,
      previousButtonColor: Colors.white,
      padding: 0,
      content: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 96.0),
            child: Container(
              height: double.infinity,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  projectType,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20.0),
                RoundedBorder(
                  radius: 10.0,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            project.name,
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          Text(
                            "팀원 모집 중", // 이 부분에 대한 json 수정 필요
                            style: TextStyle(
                              color: const Color(0xC9DE2B13),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        projectProperty,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Text(
                            project.isEnd ? "종료" : "진행중",
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            projectDate,
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: _ProjectDetailSectionView(
                            title: "팀원 정보",
                            content: List.generate(
                              project.members.length,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: _ProjectDetailMemeberView(
                                    member: project.members[index],
                                    pm: project.members[index].id ==
                                        project.pm.id,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: _ProjectDetailSectionView(
                            title: "문의사항",
                            content: [],
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectDetailSectionView extends StatelessWidget {
  const _ProjectDetailSectionView({
    Key? key,
    required this.title,
    required this.content,
    this.onTap,
  }) : super(key: key);
  final String title;
  final Function()? onTap;
  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            if (onTap != null)
              GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    Text(
                      "자세히 보기",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).textTheme.headline3!.color,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ]..addAll(content),
    );
  }
}

class _ProjectDetailMemeberView extends StatelessWidget {
  const _ProjectDetailMemeberView({
    Key? key,
    required this.member,
    this.pm,
  }) : super(key: key);
  final Member member;
  final bool? pm;

  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      radius: 10.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const DefaultProfile(size: 24.0),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    "${["디자인", "프로그래밍", "아트"][member.partIndex]} 파트",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              if (pm ?? false)
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: _TagBorder(
                    "PM",
                    color: const Color(0xC9DE2B13),
                    contentColor: Colors.white,
                  ),
                ),
              _TagBorder("역할"), // json 수정 필요
            ],
          ),
        ],
      ),
    );
  }
}

class _TagBorder extends StatelessWidget {
  const _TagBorder(
    this.content, {
    Key? key,
    this.color,
    this.contentColor,
  }) : super(key: key);
  final String content;
  final Color? color;
  final Color? contentColor;

  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      radius: 10.0,
      color: color ?? Theme.of(context).dialogBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        content,
        style: Theme.of(context).textTheme.headline2!.copyWith(
              color: contentColor,
              fontSize: 9.0,
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}