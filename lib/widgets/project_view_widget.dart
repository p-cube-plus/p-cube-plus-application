import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/project.dart';
import 'default_profile.dart';
import 'rounded_border_widget.dart';

class ProjectView extends StatelessWidget {
  const ProjectView({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      radius: 10.0,
      padding: const EdgeInsets.all(20.0),
      hasShadow: true,
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                project.name, // debug
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: List.generate(
                  project.members.length,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.only(right: index * 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0A000000),
                              blurRadius: 3.0,
                              spreadRadius: 0.0,
                              offset: Offset.fromDirection(1.0, 1.0),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: const DefaultProfile(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            "${["메인", "꼬꼬마"][project.type]} 프로젝트", // debug
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(height: 8.0),
          Row(children: [
            Text(
              project.isEnd ? "종료" : "진행중", // debug
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(width: 8.0),
            Text(
              project.startDate != null
                  ? "${DateFormat("yyyy.MM.dd").format(project.startDate!)} ~ " +
                      "${project.isEnd && project.endDate != null ? DateFormat("yyyy.MM.dd").format(project.startDate!) : ""}"
                  : "", // debug
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ]),
        ],
      ),
    );
  }
}
