import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/home/home_schedule/home_schedule.dart';
import 'package:presentation/ui/home/home_upcomming/home_upcomming_schedule.dart';
import 'package:presentation/ui/webpage/introduce_p_cube_web_page.dart';
import 'package:presentation/widgets/default_alert.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_refresh_indicator.dart';
import 'package:presentation/widgets/rounded_border.dart';

class GuestHomePage extends StatefulWidget {
  const GuestHomePage({super.key});

  @override
  State<GuestHomePage> createState() => _GuestHomePageState();
}

class _GuestHomePageState extends State<GuestHomePage>
    with AutomaticKeepAliveClientMixin {
  Key _refreshKey = UniqueKey();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _showIntroDialog());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);

    theme.neutral100;

    return DefaultPage(
      key: _refreshKey,
      title: "홈",
      content: DefaultRefreshIndicator(
        onRefresh: () async {
          setState(() {
            _refreshKey = UniqueKey();
          });
        },
        child: DefaultContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntroducePCubeTile(),
              SizedBox(height: 40),
              HomeUpcommingSchedule(),
              HomeSchedule(),
            ],
          ),
        ),
      ),
    );
  }

  void _showIntroDialog() {
    DialogBuilder().build(
      context,
      DefaultAlert(
        title: "어서오세요!",
        description: """PCube+는 세종대학교 게임제작 동아리
판도라큐브를 지원하는 편의 서비스입니다.
게스트 모드로 PCube+를 먼저 둘러보세요.""",
        descriptionColor: Theme.of(context).neutral40,
        messageType: MessageType.okCancel,
        cancelString: "소개 바로가기",
        onTapCancel: () => _navigateToPCubeIntroducePage(),
        okString: "PCube+둘러보기",
      ),
    );
  }

  void _navigateToPCubeIntroducePage() {
    Future.microtask(() {
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => IntroducePCubeWebPage(),
        ),
      );
    });
  }
}

class IntroducePCubeTile extends StatelessWidget {
  const IntroducePCubeTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "판도라큐브 소개",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: theme.neutral100,
          ),
        ),
        SizedBox(height: 8),
        RoundedBorder(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          onTap: () => _navigateToPCubeIntroducePage(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "판도라큐브 소개 바로가기",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: theme.neutral100,
                ),
              ),
              Icon(
                Icons.navigate_next_rounded,
                color: theme.neutral40,
                size: 24,
              )
            ],
          ),
        )
      ],
    );
  }

  void _navigateToPCubeIntroducePage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => IntroducePCubeWebPage(),
      ),
    );
  }
}
