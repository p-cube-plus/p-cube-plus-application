import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/user/value_objects/user_project_detail.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_participated_project/user_participated_project_view_model.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_profile_list.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:provider/provider.dart';

class UserParticipatedProjectPage extends StatelessWidget {
  const UserParticipatedProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserParticipatedProjectViewModel(),
      child: _UserParticipatedProjectPage(),
    );
  }
}

class _UserParticipatedProjectPage extends StatefulWidget
    with ViewModel<UserParticipatedProjectViewModel> {
  _UserParticipatedProjectPage();

  @override
  State<_UserParticipatedProjectPage> createState() =>
      _UserParticipatedProjectPageState();
}

class _UserParticipatedProjectPageState
    extends State<_UserParticipatedProjectPage> {
  var refreshKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(),
      title: "참여 프로젝트",
      content: DefaultFutureBuilder(
        key: refreshKey,
        fetchData: widget.read(context).fetchUserProjectDetail(),
        showOnLoadedWidget:
            (BuildContext context, List<UserProjectDetail> data) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return RoundedBorder(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 16),
                padding: EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index].title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: theme.neutral100,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "${data[index].type}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: theme.neutral100,
                          ),
                        ),
                        Text(
                          "진행중 ${data[index].startDate.format("yyyy.MM.dd")} ~ ${data[index].endDate?.format("yyyy.MM.dd") ?? ""}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: theme.neutral40,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: DefaultProfileList(
                        itemCount: data[index].memberCount,
                        size: 24,
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
        showOnErrorWidget: (error, trace) {
          return GestureDetector(
            onTap: () => setState(() => refreshKey = UniqueKey()),
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Text(
                  "$error로 인해\n데이터 불러오기에 실패했습니다.\n터치해서 새로고침하기",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
