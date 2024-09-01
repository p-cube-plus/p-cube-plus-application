import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/providers/api_provider/composite/user_data_provider.dart';
import 'package:p_cube_plus_application/widgets/common/default_futureBuilder.dart';
import 'package:p_cube_plus_application/widgets/common/default_refreshIndicator.dart';
import '../../common/utils/contants.dart' as Constants;
import '../../../../presentation/lib/widgets/rounded_border.dart';
import '../../widgets/page/default_appbar.dart';
import '../../../../presentation/lib/widgets/default_content.dart';
import '../../widgets/page/default_page.dart';

class PromotionProgressPage extends StatelessWidget {
  const PromotionProgressPage({required this.userProvider});
  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return DefaultRefreshIndicator(
      refreshFunction: userProvider.refresh,
      child: DefaultFutureBuilder(
        fetchData: userProvider.fetch(),
        showFunction: (user) => DefaultPage(
          title: "승급 진행률",
          appbar: DefaultAppBar(),
          content: DefaultContent(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Row(children: [
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text(
                        "${(user.promotionProgress.progress * 100).round()}%", // debug
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                    Expanded(
                        child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        RoundedBorder(
                          radius: 8.0,
                          height: 16.0,
                          color: const Color(0x1ADE2B13),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: (user.promotionProgress.progress * 100)
                                  .toInt(),
                              child: RoundedBorder(
                                radius: 8.0,
                                height: 16.0,
                                color: const Color(0xCCDE2B13),
                              ),
                            ),
                            Expanded(
                                flex: ((1 - user.promotionProgress.progress) *
                                        100)
                                    .toInt(),
                                child: Container()),
                          ],
                        ),
                      ],
                    )),
                  ]),
                ),
                PromotionRequirement(requirement: PeriodRequirement(1)),
                PromotionRequirement(requirement: WorkshopRequirement(2)),
                PromotionRequirement(requirement: ProjectRequirement(1)),
                PromotionRequirement(
                    requirement: PartRequirement(false, "플로우 차트와 데이터 테이블")),
                PromotionRequirement(requirement: VoteRequirement(false)),
              ],
            ),
            bottomButtonText: "승급 신청하기",
          ),
        ),
      ),
    );
  }
}

class PromotionRequirement extends StatelessWidget {
  const PromotionRequirement({required this.requirement});
  final Requirement requirement;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: RoundedBorder(
        onTap: () {},
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text(
                        requirement.title,
                        style: theme.textTheme.displayLarge!.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    if (requirement.isDone)
                      Constants.Constants.GetIcon(Constants.Constants.check),
                  ],
                ),
                if (requirement.description != null)
                  Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                      requirement.description!,
                      style: theme.textTheme.displaySmall!
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  )
              ],
            ),
            Text(
              requirement.state.toString(),
              style: theme.textTheme.displaySmall!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: requirement.isDone
                      ? const Color(0xFF25CA85)
                      : theme.textTheme.displaySmall!.color),
            ),
          ],
        ),
      ),
    );
  }
}

class Requirement {
  late String title;
  late Object state;
  bool isDone = false;
  String? description;
}

class PeriodRequirement extends Requirement {
  PeriodRequirement(int state) {
    title = "활동 기간";
    if (state >= 2) isDone = true;
    super.state = NumberFormat("#학기").format(state);
  }
}

class WorkshopRequirement extends Requirement {
  WorkshopRequirement(int state) {
    title = "워크샵 참여";
    if (state >= 2) isDone = true;
    super.state = NumberFormat("#회").format(state);
  }
}

class ProjectRequirement extends Requirement {
  ProjectRequirement(int state) {
    title = "프로젝트 참여";
    if (state >= 1) isDone = true;
    super.state = NumberFormat("#회").format(state);
  }
}

class PartRequirement extends Requirement {
  PartRequirement(bool state, String description) {
    title = "파트 교육과정";
    isDone = state;
    super.description = description;
    if (state)
      super.state = "완료";
    else
      super.state = "진행중";
  }
}

class VoteRequirement extends Requirement {
  VoteRequirement(bool state) {
    super.title = "승급투표";
    isDone = state;
    if (state)
      super.state = "완료";
    else
      super.state = "진행전";
  }
}
