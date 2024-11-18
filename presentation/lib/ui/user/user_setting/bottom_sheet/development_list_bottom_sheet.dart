import 'package:domain/member/value_objects/developer_member.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_setting/user_setting_view_model.dart';
import 'package:presentation/widgets/default_profile.dart';

class DevelopmentListBottomSheet extends StatelessWidget
    with ViewModel<UserSettingViewModel> {
  DevelopmentListBottomSheet({super.key, required this.listData});

  final List<DeveloperMember> listData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 16),
          child: Text(
            "개발진 목록",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: theme.neutral100,
            ),
          ),
        ),
        Column(
          children: List.generate(listData.length, (index) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: DefaultProfile(size: 28),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listData[index].name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: theme.neutral80,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "${listData[index].departmentName} ${listData[index].studentNumber}학번",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: theme.neutral80,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${listData[index].partType}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: theme.neutral80,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "${listData[index].positionType}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: theme.neutral40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (index != 6)
                  Divider(
                    color: theme.neutral10,
                    height: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
              ],
            );
          }),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
