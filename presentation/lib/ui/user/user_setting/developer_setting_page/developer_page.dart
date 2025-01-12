import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_setting/developer_setting_page/developer_view_model.dart';
import 'package:presentation/ui/user/user_setting/test_beacon/test_beacon_page.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_text_field.dart';
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

class _DeveloperPage extends StatefulWidget {
  const _DeveloperPage();

  @override
  State<_DeveloperPage> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<_DeveloperPage>
    with ViewModel<DeveloperViewModel> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

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
              (viewModel) => viewModel.mockDelay,
              (context, mockDelay) {
                _textEditingController.text = mockDelay.toString();
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text("Mock 데이터 가져오는 시간 (타임아웃: 5초)")),
                      Container(
                        color: theme.neutral10,
                        height: 20,
                        width: 50,
                        child: DefaultTextField(
                          maxLength: 3,
                          contentPadding: 2,
                          inputController: _textEditingController,
                          onChanged: (newValueString) {
                            final newValue = double.tryParse(newValueString);
                            if (newValue == null) return;
                            read(context).updatemockDelay(newValue);
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,}$'),
                            ),
                          ],
                        ),
                      ),
                      Text("초"),
                    ],
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
                        Text("Mock Exception 테스트"),
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
              onTap: () => _navigateToTestBeaconPage(),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 12,
                  ),
                  child: Text("비콘 테스트"),
                ),
              ),
            ),
            DefaultFutureBuilder(
              fetchData: read(context).fetchFcmToken(),
              showOnLoadedWidget: (context, data) {
                return InkWell(
                  onTap: () => _copyFcm(data ?? ""),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("FCM TOKEN"),
                        Text(data ?? ""),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToTestBeaconPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TestBeaconPage(),
      ),
    );
  }

  void _copyFcm(String data) {
    Clipboard.setData(ClipboardData(text: data));
  }
}
