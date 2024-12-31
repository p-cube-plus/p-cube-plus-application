import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_view_model.dart';
import 'package:presentation/ui/user/user_warning/user_warning_page.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

class UserWarningTile extends StatefulWidget with ViewModel<UserViewModel> {
  const UserWarningTile({super.key});

  @override
  State<UserWarningTile> createState() => _UserWarningTileState();
}

class _UserWarningTileState extends State<UserWarningTile> {
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
              "경고 현황",
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
          fetchData: widget.read(context).fetchUserWarning(),
          showOnLoadedWidget: (context, data) {
            return RoundedBorder(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "누적 경고 횟수",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: theme.neutral100,
                    ),
                  ),
                  Text(
                    "총 ${data.cumulativeWarningCount}회",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: theme.primary80,
                    ),
                  ),
                ],
              ),
            );
          },
          showOnLoadingWidget: (context) {
            return RoundedBorder(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "누적 경고 횟수",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: theme.neutral100,
                    ),
                  ),
                  SkeletonAnimation(80, 14, radius: 50),
                ],
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
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => UserWarningPage()));
  }
}
