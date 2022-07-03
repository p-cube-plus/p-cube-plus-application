import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../widgets/curriculum_progress.dart';
import 'package:provider/provider.dart';

import '../../models/seminar.dart';
import '../../providers/user_data.dart';
import '../../models/user.dart';
import '../../widgets/setting_list_widget.dart';
import '../../widgets/list_divider.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../../widgets/rounded_border.dart';

import 'caution_list_page.dart';
import 'seminar_list_page.dart';

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
            CustomAppBar(
              title: "내 정보",
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingListWidget()),
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
            Expanded(
              child: SingleChildScrollView(
                child: InformationList(),
              ),
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
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
    var userProvider = context.watch<UserDataProvider>();
    if (!userProvider.isLoaded) return Container();

    // 필요한 위젯들을 추가하는 과정? build에 이걸 다 넣어도 괜찮은지 모르겠음
    // 코드 마음에 안들어요
    List<Widget> widgets = <Widget>[const ProfileView()];
    widgets
      ..add(const ListDivider()) // Divider랑 SummaryView 합칠지 고민중
      ..add(
        ContentSummaryView(
          title: "경고 현황",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CautionListPage(
                  userProvider: userProvider,
                ),
              ),
            );
          },
          descript: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "내역 보기",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          children: List.generate(
            3,
            (index) {
              double _count = userProvider.totalCaution(2 - index);
              String _value = _count == _count.round()
                  ? _count.toInt().toString()
                  : _count.toString();

              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ["경고", "주의", "총"][index],
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Colors.black,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w300,
                              ),
                    ),
                    Text(
                      "${_value}회",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                            color: Colors.black,
                            fontSize: 11.0,
                            fontWeight:
                                index == 2 ? FontWeight.w500 : FontWeight.w300,
                          ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

    widgets
      ..add(const ListDivider())
      ..add(
        ContentSummaryView(
          title: "참여 중인 프로젝트",
          onTap: () {},
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  RoundedBorder(
                    radius: 16.0,
                    height: 46.0,
                    child: InformationSummaryBar(
                      title: "PCube+",
                      description: ["메인 프로젝트", "꼬꼬마 프로젝트"][0],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

    widgets
      ..add(const ListDivider())
      ..add(
        ContentSummaryView(
          title: "승급 진행률",
          onTap: () {},
          descript: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "${(userProvider.user!.curriculum.progress * 100).round()}%", // debug
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Stack(
                children: [
                  RoundedBorder(
                    radius: 8.0,
                    height: 16.0,
                    color: Color(0xFFF9D4CF),
                  ),
                ],
              ),
            ),
            CurriculumProgressView(userProvider: userProvider),
          ],
        ),
      );

    widgets
      ..add(const ListDivider()) // Divider랑 SummaryView 합칠지 고민중
      ..add(
        ContentSummaryView(
          title: "세미나 참여 정보",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SeminarListPage(
                  userProvider: userProvider,
                ),
              ),
            );
          },
          children: List.generate(userProvider.user!.seminars.length, (index) {
            Seminar seminar = userProvider.user!.seminars[index];

            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                children: [
                  InformationSummaryBar(
                    title: DateFormat("MM/dd").format(seminar.date),
                    description: "${["수습회원", "정회원", "졸업생"][seminar.type]} 세미나",
                  ),
                ],
              ),
            );
          }),
        ),
      );

    widgets.add(SizedBox(height: 20.0)); // 하단 공백

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      ),
    );
  }
}

class InformationSummaryBar extends StatelessWidget {
  const InformationSummaryBar({
    Key? key,
    required this.title,
    this.description,
    this.height,
  }) : super(key: key);
  final String title;
  final String? description;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      radius: 16.0,
      height: height ?? 46.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Text(
              title, // debug
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  description ?? "", // debug
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Color(0xFF2E2E2E),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ),
            ViewDetailButton(
                //onTap: () {},
                ),
          ],
        ),
      ),
    );
  }
}

class ViewDetailButton extends StatelessWidget {
  const ViewDetailButton({
    Key? key,
    this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    //this.onTap,
  }) : super(key: key);

  final String? text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  //final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "자세히 보기",
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: color ?? Color(0xFF2E2E2E),
            fontSize: fontSize ?? 12.0,
            fontWeight: fontWeight ?? FontWeight.w400,
          ),
    );
  }
}

class ContentSummaryView extends StatelessWidget {
  const ContentSummaryView({
    Key? key,
    required this.title,
    this.descript,
    required this.onTap,
    this.children,
  }) : super(key: key);

  final String title;
  final Widget? descript;
  final List<Widget>? children;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // 여기 코드 마음에 안들어요
    List<Widget> _barContents = <Widget>[
      Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
      ),
      GestureDetector(
        onTap: onTap,
        child: const Icon(Icons.chevron_right),
      ),
    ];
    if (descript != null) _barContents.insert(1, Expanded(child: descript!));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _barContents,
          ),
        ]..addAll(children ?? []),
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
              user?.name ?? "Unknown",
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
