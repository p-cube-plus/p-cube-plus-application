import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class StatusPending extends StatelessWidget {
  final double size;
  const StatusPending({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFFABABAB),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x4DABABAB),
            offset: Offset.fromDirection(0.0, 2.0),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: SvgPicture.asset(
        asset.minus,
        colorFilter: ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
        width: size * 0.5,
      ),
    );
  }
}
