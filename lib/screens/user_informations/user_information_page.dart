import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/remote_f/models/user_profile_dto.dart';
import 'package:p_cube_plus_application/remote_f/models/user_project_dto.dart';
import 'package:p_cube_plus_application/providers/api_provider/composite/user_data_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/user_profile_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/user_project_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/user_warning_provider.dart';
import 'package:p_cube_plus_application/screens/user_informations/caution_list_page.dart';
import 'package:p_cube_plus_application/common/utils/num_tools.dart';
import 'package:p_cube_plus_application/widgets/common/default_futureBuilder.dart';
import 'package:p_cube_plus_application/widgets/common/default_refreshIndicator.dart';
import 'package:provider/provider.dart';

import '../../widgets/common/default_profile.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/home/content_summary_view.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';
import '../user_informations/project_list_page.dart';
import '../settings/setting_page.dart';

class UserInformationPage extends StatelessWidget {
  const UserInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userProvider = UserDataProvider(
      context.watch<UserProfileProvider>(),
      context.watch<UserProjectProvider>(),
      context.watch<UserWarningProvider>(),
    );

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
      content:
          DefaultContent(child: InformationList(userProvider: userProvider)),
    );
  }
}

class InformationList extends StatelessWidget {
  const InformationList({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return DefaultRefreshIndicator(
      refreshFunction: userProvider.refresh,
      child: DefaultFutureBuilder(
          fetchData: userProvider.fetch(),
          showFunction: (data) => Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ProfileView(userData: data[#UserProfileProvider].data),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    "총 ${DoubleToInt.autoFix(data[#UserWarningProvider].data.totalWarning)}회", // debug
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
                        data[#UserProjectProvider].data.length,
                        (index) {
                          UserProjectDTO project =
                              data[#UserProjectProvider].data[index];

                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: RoundedBorder(
                              height: 48.0,
                              hasShadow: true,
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      "${project.type} 프로젝트", // debug
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
              )),
    );
  }
}

class ProfileView extends StatelessWidget {
  ProfileView({Key? key, required this.userData}) : super(key: key);

  UserProfileDTO userData;

  @override
  Widget build(BuildContext context) {
    bool _hasProfile = false;
    Widget profile = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          onError: (exception, stackTrace) => _hasProfile = false,
          image: Image.network(userData.profileImage ?? "").image,
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
              userData.name,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 2.0),
            GestureDetector(
              onTap: () {}, // 회원 목록 보기?
              child: Text(
                userData.level,
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
