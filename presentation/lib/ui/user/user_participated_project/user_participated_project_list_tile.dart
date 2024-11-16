import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_participated_project/user_participated_project_page.dart';
import 'package:presentation/ui/user/user_view_model.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/rounded_border.dart';

class UserParticipatedProjectListTile extends StatelessWidget
    with ViewModel<UserViewModel> {
  const UserParticipatedProjectListTile({super.key});

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
          fetchData: read(context).fetchUserProject(),
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
