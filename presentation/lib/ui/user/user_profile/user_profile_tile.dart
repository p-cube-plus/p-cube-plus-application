import 'package:domain/user/value_objects/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_view_model.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_profile.dart';

class UserProfileTile extends StatefulWidget with ViewModel<UserViewModel> {
  const UserProfileTile({super.key});

  @override
  State<UserProfileTile> createState() => _UserProfileTileState();
}

class _UserProfileTileState extends State<UserProfileTile> {
  var _refreshKey = UniqueKey();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultFutureBuilder(
      key: _refreshKey,
      fetchData: widget.read(context).fetchUserProfile(),
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
        return GestureDetector(
          onTap: () => setState(() => _refreshKey = UniqueKey()),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              "$error로 인해\n데이터 불러오기에 실패했습니다.\n터치해서 새로고침하기",
            ),
          ),
        );
      },
    );
  }
}
