enum MemberWarningType {
  caution,
  warning,
  deduction,
  ;

  @override
  String toString() {
    return switch (this) {
      MemberWarningType.caution => "주의",
      MemberWarningType.warning => "경고",
      MemberWarningType.deduction => "경고 차감",
    };
  }
}
