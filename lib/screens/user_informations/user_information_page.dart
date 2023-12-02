import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/models/user/user_project.dart';
import 'package:p_cube_plus_application/models/user/user_warning.dart';
import 'package:p_cube_plus_application/screens/user_informations/caution_list_page.dart';
import 'package:p_cube_plus_application/widgets/common/default_futureBuilder.dart';
import 'package:provider/provider.dart';

import '../../widgets/common/default_profile.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/home/content_summary_view.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';
import '../user_informations/project_list_page.dart';

import '../../providers/user_data_provider.dart';
import '../../models/user/user_profile.dart';

import '../settings/setting_page.dart';

class UserInformationPage extends StatelessWidget {
  const UserInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "내 정보",
      action: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingPage(),
            ),
          );
        },
        child: Icon(
          Icons.settings,
          color: Theme.of(context).textTheme.headline2!.color,
        ),
      ),
      content: DefaultContent(child: InformationList()),
    );
  }
}

class InformationList extends StatelessWidget {
  const InformationList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<UserDataProvider>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DefaultFutureBuilder(
          future: userProvider.updateWarning(),
          showFunction: (UserWarning warning) => Column(
            children: [
              const SizedBox(height: 40.0),
              ContentSummaryView(
                title: "경고 현황",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CautionListPage(),
                    ),
                  );
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RoundedBorder(
                      height: 48.0,
                      hasShadow: true,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "누적 경고 횟수", // debug
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            Text(
                              "총 ${userProvider.warning}회", // debug
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        DefaultFutureBuilder(
          future: userProvider.updateProject(),
          showFunction: (List<UserProject> projects) => Column(
            children: [
              const SizedBox(height: 40.0),
              ContentSummaryView(
                title: "참여 프로젝트",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProjectListPage(),
                    ),
                  );
                },
                children: List.generate(
                  projects.length,
                  (index) {
                    UserProject project = projects[index];

                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RoundedBorder(
                        height: 48.0,
                        hasShadow: true,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                project.name, // debug
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Text(
                                "${project.type}", // debug
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
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
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProfile? user = context.watch<UserDataProvider>().profile;
    bool _hasProfile = false;
    Widget profile = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          onError: (exception, stackTrace) => _hasProfile = false,
          image: Image.network(user!.profileImage ?? "").image,
          fit: BoxFit.fill,
        ),
      ),
    );

    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: _hasProfile ? profile : const DefaultProfile(size: 72),
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 2.0),
            GestureDetector(
              onTap: () {}, // 회원 목록 보기?
              child: Text(
                user.level,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            )
          ],
        )
      ],
    );
  }
}
