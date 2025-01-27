import 'package:domain/fee/repository/fee_repository.dart';
import 'package:domain/fee/value_object/account_information.dart';
import 'package:get_it/get_it.dart';

class FetchAccountInformationUseCase {
  final _feeRepository = GetIt.I.get<FeeRepository>();

  Future<AccountInformation> call() async {
    return await _feeRepository.getAccountInformation();
  }
}
