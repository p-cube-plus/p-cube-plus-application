import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_participated_project/user_participated_project_page.dart';
import 'package:presentation/ui/user/user_view_model.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

class UserParticipatedProjectListTile extends StatefulWidget
    with ViewModel<UserViewModel> {
  const UserParticipatedProjectListTile({super.key});

  @override
  State<UserParticipatedProjectListTile> createState() =>
      _UserParticipatedProjectListTileState();
}

class _UserParticipatedProjectListTileState
    extends State<UserParticipatedProjectListTile> {
  var _refreshKey = UniqueKey();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "참여 프로젝트",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.neutral100,
              ),
            ),
            GestureDetector(
              onTap: () => _navigateToDetailPage(context),
              child: Row(
                children: [
                  Text(
                    "자세히 보기",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral60,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: theme.neutral60,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        DefaultFutureBuilder(
          key: _refreshKey,
          fetchData: widget.read(context).fetchUserProject(),
          showOnLoadedWidget: (context, data) {
            return Column(
              children: List.generate(data.length, (index) {
                return RoundedBorder(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data[index].title,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: theme.neutral100,
                        ),
                      ),
                      Text(
                        "${data[index].projectType}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: theme.neutral40,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          },
          showOnLoadingWidget: (context) {
            return Column(
              children: List.generate(
                2,
                (index) {
                  return RoundedBorder(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SkeletonAnimation(140, 14),
                        SkeletonAnimation(108, 14),
                      ],
                    ),
                  );
                },
              ),
            );
          },
          showOnErrorWidget: (error, trace) {
            return GestureDetector(
              onTap: () => setState(() => _refreshKey = UniqueKey()),
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    "데이터 불러오기에 실패했습니다!\n터치해서 새로고침하기",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _navigateToDetailPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UserParticipatedProjectPage(),
    ));
  }
}
