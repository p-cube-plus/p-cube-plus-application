enum AttendanceStatusType {
  blank,
  success,
  failed,
  late,
  pending;

  @override
  String toString() {
    return switch (this) {
      AttendanceStatusType.blank => "공결",
      AttendanceStatusType.success => "출결",
      AttendanceStatusType.failed => "실패",
      AttendanceStatusType.late => "지각",
      AttendanceStatusType.pending => "보류",
    };
  }

  static AttendanceStatusType fromIndex(int index) {
    return AttendanceStatusType.values[index];
  }
}
