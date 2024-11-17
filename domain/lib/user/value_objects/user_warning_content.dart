import 'package:domain/member/value_objects/member_warning_type.dart';
import 'package:meta/meta.dart';

@immutable
class UserWarningContent {
  final MemberWarningType warningType;
  final String desceiption;
  final DateTime warningDate;
  final double warningPoint; // 경고 추가는 양수, 경고 차감은 음수
  const UserWarningContent({
    required this.warningType,
    required this.desceiption,
    required this.warningDate,
    required this.warningPoint,
  });
}
