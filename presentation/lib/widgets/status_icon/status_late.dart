import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class StatusLate extends StatelessWidget {
  final double size;
  const StatusLate({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFFFFAF65),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x4DFFAF65),
            offset: Offset.fromDirection(0.0, 2.0),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: SvgPicture.asset(
        asset.check,
        colorFilter: ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
        width: size * 0.5,
        height: size * 0.5,
      ),
    );
  }
}
