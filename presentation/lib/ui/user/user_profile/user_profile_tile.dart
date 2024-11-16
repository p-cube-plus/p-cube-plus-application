import 'package:domain/user/value_objects/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_view_model.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_profile.dart';

class UserProfileTile extends StatelessWidget with ViewModel<UserViewModel> {
  const UserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultFutureBuilder(
      fetchData: read(context).fetchUserProfile(),
      showOnLoadedWidget: (BuildContext context, UserProfile data) {
        return Row(
          children: [
            DefaultProfile(size: 72),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: theme.neutral100,
                  ),
                ),
                Text(
                  "${data.partType.name} / ${data.positionType}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: theme.neutral60,
                  ),
                ),
              ],
            ),
          ],
        );
      },
      showOnErrorWidget: (error, trace) {
        return Text("유저 데이터 불러오기 실패! 새로고침하기");
      },
    );
  }
}
