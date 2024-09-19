import 'package:meta/meta.dart';

@immutable
class LoginConfirmInfoData {
  final bool isVerified;

  const LoginConfirmInfoData({
    required this.isVerified,
  });
}
