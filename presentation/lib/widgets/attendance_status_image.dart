import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class AttendanceStatusImage extends StatelessWidget {
  final AttendanceStatusType type;
  final double width;
  final double height;

  const AttendanceStatusImage(
    this.type, {
    super.key,
    this.width = 68,
    this.height = 68,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _getAssetPath(),
      width: width,
      height: height,
    );
  }

  _getAssetPath() {
    return switch (type) {
      AttendanceStatusType.blank => asset.blank,
      AttendanceStatusType.success => asset.success,
      AttendanceStatusType.failed => asset.failed,
      AttendanceStatusType.late => asset.late,
      AttendanceStatusType.pending => asset.off,
    };
  }
}
