import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class DefaultRefreshIndicator extends StatelessWidget {
  const DefaultRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final Future onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: -60,
      color: Theme.of(context).primary80,
      onRefresh: () async => await onRefresh,
      child: child,
    );
  }
}
