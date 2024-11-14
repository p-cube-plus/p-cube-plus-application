import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/default_profile.dart';
import 'dart:math';

class DefaultProfileList extends StatelessWidget {
  const DefaultProfileList(
      {super.key, required this.itemCount, required this.size});

  final int overFlowCount = 6;
  final int itemCount;
  final double size;

  @override
  Widget build(BuildContext context) {
    final generateCount = min(itemCount, overFlowCount);
    final isOverFlow = generateCount == overFlowCount;
    return Stack(
      alignment: Alignment.topRight,
      children: List.generate(
        generateCount,
        (index) {
          if (isOverFlow && index == 0) {
            return _RemainCountItem(
                size: size, remainCount: itemCount - overFlowCount);
          }
          return Padding(
            padding: EdgeInsets.only(right: index * (size - 4)),
            child: DefaultProfile(size: size),
          );
        },
      ),
    );
  }
}

class _RemainCountItem extends StatelessWidget {
  final double size;
  final int remainCount;
  const _RemainCountItem({
    required this.size,
    required this.remainCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.neutral10,
        boxShadow: [
          BoxShadow(
            color: theme.neutral20,
            offset: Offset.fromDirection(1.0, 1.0),
            blurRadius: 3.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          "+$remainCount",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: theme.neutral40,
          ),
        ),
      ),
    );
  }
}
