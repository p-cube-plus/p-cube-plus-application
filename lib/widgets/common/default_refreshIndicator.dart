import 'package:flutter/material.dart';

class DefaultRefreshIndicator extends StatelessWidget {
  DefaultRefreshIndicator({
    this.refreshFunction,
    required this.child,
  });
  final Future? refreshFunction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: -60,
      color: Theme.of(context).primaryColor,
      onRefresh: () async => await refreshFunction,
      child: child,
    );
  }
}
