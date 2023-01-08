import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/widgets/rounded_border_widget.dart';
import '../../models/project.dart';
import '../../widgets/default_page_widget.dart';

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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
