import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/user/value_objects/user_warning_detail.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_warning/user_warning_view_model.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:provider/provider.dart';

class UserWarningPage extends StatelessWidget {
  const UserWarningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserWarningViewModel(),
      child: const _UserWarningPage(),
    );
  }
}

class _UserWarningPage extends StatefulWidget
    with ViewModel<UserWarningViewModel> {
  const _UserWarningPage();

  @override
  State<_UserWarningPage> createState() => _UserWarningPageState();
}

class _UserWarningPageState extends State<_UserWarningPage> {
  var refreshKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      title: "경고 현황",
      appbar: DefaultAppBar(),
      content: DefaultFutureBuilder(
        key: refreshKey,
        fetchData: widget.read(context).fetchUserWarningDetail(),
        showOnLoadedWidget: (BuildContext context, UserWarningDetail data) {
          return DefaultContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "주의 및 경고",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: theme.neutral60,
                      ),
                    ),
                    Text(
                      "${data.warningCount}회",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: theme.neutral100,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "경고 차감",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: theme.neutral60,
                      ),
                    ),
                    Text(
                      "${data.warningReductionCount}회",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: theme.neutral100,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "총",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: theme.neutral60,
                      ),
                    ),
                    Text(
                      "${data.totlaCount}회",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: theme.neutral100,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Divider(
                  height: 1,
                  color: theme.neutral10,
                ),
                SizedBox(height: 24),
                Text(
                  "주의 및 경고 내역",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: theme.neutral60,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(data.warningHistory.length, (index) {
                    return RoundedBorder(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data.warningHistory[index].warningType}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: theme.neutral100,
                                ),
                              ),
                              Text(
                                "${data.warningHistory[index].desceiption} (${data.warningHistory[index].warningPoint})",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: theme.neutral40,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            data.warningHistory[index].warningDate
                                .format("yyyy.MM.dd"),
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
                ),
                SizedBox(height: 32),
                Text(
                  "경고 차감 내역",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: theme.neutral60,
                  ),
                ),
                SizedBox(height: 8),
                Column(
                  children: List.generate(data.warningReductionHistory.length,
                      (index) {
                    return RoundedBorder(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data.warningReductionHistory[index].warningType}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: theme.neutral100,
                                ),
                              ),
                              Text(
                                "${data.warningReductionHistory[index].desceiption} (${-data.warningReductionHistory[index].warningPoint})",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: theme.neutral40,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            data.warningReductionHistory[index].warningDate
                                .format("yyyy.MM.dd"),
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
                ),
              ],
            ),
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
