import 'package:meta/meta.dart';

@immutable
class AccountInformation {
  final String accountBank;
  final String accountNumber;
  final String accountOwnerName;
  AccountInformation({
    required this.accountBank,
    required this.accountNumber,
    required this.accountOwnerName,
  });
}
