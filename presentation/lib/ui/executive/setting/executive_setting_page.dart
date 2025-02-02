import 'package:flutter/material.dart';
import 'package:presentation/ui/executive/setting/expandable_setting_widget/beacon_setting/expandable_beacon_setting_widget.dart';
import 'package:presentation/ui/executive/setting/expandable_setting_widget/fee_setting/expandable_fee_setting_widget.dart';
import 'package:presentation/ui/executive/setting/expandable_setting_widget/web_view_setting/expandable_web_view_setting_widget.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';

class ExecutiveSettingPage extends StatelessWidget {
  const ExecutiveSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: "임원진 설정",
      ),
      content: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus
            ?.unfocus(disposition: UnfocusDisposition.scope),
        child: DefaultContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpandableBeaconSettingWidget(),
              SizedBox(height: 8),
              ExpandableFeeSettingWidget(),
              SizedBox(height: 8),
              ExpandableWebViewSettingWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
