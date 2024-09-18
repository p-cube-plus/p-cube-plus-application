import 'package:data/remote/di.dart' as remote_di;
import 'package:data/local/di.dart' as local_di;
import 'package:data/di.dart' as data_di;

void initService() {
  remote_di.registRemoteDatasource();
  local_di.registLocalDatasource();
  data_di.registRepository();
}
