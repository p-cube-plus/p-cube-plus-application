import 'dart:io';

import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_setting/developer_setting_page/developer_view_model.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:provider/provider.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DeveloperViewModel(),
      child: _DeveloperPage(),
    );
  }
}

class _DeveloperPage extends StatelessWidget
    with ViewModel<DeveloperViewModel> {
  const _DeveloperPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(),
      title: "개발자 설정",
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 12,
              ),
              child: Text(
                  "Dart 버전: ${Platform.version.split(" ").first}\n설정을 잘못했으면 앱 캐시를 삭제해주세요."),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              color: theme.neutral10,
            ),
            watchWidget(
              (viewModel) => viewModel.isMocking,
              (context, isMocking) {
                return InkWell(
                  onTap: () => read(context).updateIsMocking(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mock 데이터로 대체하기"),
                        Text(isMocking ? "ON" : "OFF"),
                      ],
                    ),
                  ),
                );
              },
            ),
            watchWidget(
              (viewModel) => viewModel.isTestingEmptyData,
              (context, isTestingEmptyData) {
                return InkWell(
                  onTap: () => read(context).updateIsTestingEmptyData(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Empty Data 테스트"),
                        Text(isTestingEmptyData ? "ON" : "OFF"),
                      ],
                    ),
                  ),
                );
              },
            ),
            watchWidget(
              (viewModel) => viewModel.isTestingException,
              (context, isTestingException) {
                return InkWell(
                  onTap: () => read(context).updateIsTestingException(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Exception 테스트"),
                        Text(isTestingException ? "ON" : "OFF"),
                      ],
                    ),
                  ),
                );
              },
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              color: theme.neutral10,
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("알람 테스트"),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("비콘 테스트"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
