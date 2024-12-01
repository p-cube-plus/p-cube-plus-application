import 'package:data/remote/di.dart' as remote_di;
import 'package:data/local/di.dart' as local_di;
import 'package:data/di.dart' as data_di;
import 'package:data/di_mock.dart' as mock_di;
import 'package:flutter/foundation.dart';
import 'package:data/get_mock_data_setting.dart' as mock_setting;

Future<void> registService() async {
  remote_di.registRemoteDatasource();
  await local_di.registLocalDatasource();

  final isMocking = kDebugMode && mock_setting.getMockDataSetting();
  if (isMocking) {
    mock_di.registRepository();
  } else {
    data_di.registRepository();
  }
}
