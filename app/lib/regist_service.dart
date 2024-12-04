import 'package:data/remote/di.dart' as remote_di;
import 'package:data/local/di.dart' as local_di;
import 'package:data/di.dart' as data_di;
import 'package:data/di_mock.dart' as mock_di;
import 'package:flutter/foundation.dart';
import 'package:data/app_start_up_functions.dart';

Future<void> registService() async {
  remote_di.registRemoteDatasource();
  await local_di.registLocalDatasource();

  final isMocking = kDebugMode && getMockDataSetting();
  if (isMocking) {
    mock_di.registRepository();
  } else {
    data_di.registRepository();
  }
}
