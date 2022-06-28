import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/user_data.dart';
import '../models/user.dart';
import '../widgets/setting_list_widget.dart';

class UserInformationPage extends StatelessWidget {
  const UserInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Theme.of(context).backgroundColor,
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDataProvider>(
          create: (_) => UserDataProvider(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            const CustomAppBar(),
            const InformationList(),
          ],
        ),
      ),
    );
  }
}

class InformationList extends StatelessWidget {
  const InformationList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<UserDataProvider>().user;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          const ProfileView(),
          const SizedBox(height: 18.0),
          SummaryView(
            title: "참여 중인 프로젝트",
            body: "${user?.projects.length ?? 0} 건",
            onTap: () {},
          ),
          SummaryView(
            title: "경고 현황",
            body: "총 ${context.watch<UserDataProvider>().totalCaution}회",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class SummaryView extends StatelessWidget {
  const SummaryView({
    Key? key,
    required this.title,
    required this.body,
    required this.onTap,
  }) : super(key: key);

  final String title, body;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.black,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  body,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<UserDataProvider>().user;
    bool _hasProfile = user?.profile == null;

    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: SizedBox(
            width: 58.0,
            height: 58.0,
            child: _hasProfile
                ? Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 209, 209, 209),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Color.fromARGB(230, 163, 163, 163),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 209, 209, 209),
                      image: DecorationImage(
                        image: NetworkImage(user!.profile!),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user?.name ?? "",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {}, // 파트 회원 목록 보기?
                  child: Text(
                    "${["디자인", "프로그래밍", "아트"][user?.partIndex ?? 0]} 파트",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: () {}, // 회원 목록 보기?
                  child: Text(
                    "정회원",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84.0,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "내 정보",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingListWidget()),
              );
            }, // 설정 화면으로 이동
            child: Text(
              "설정",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
