import 'package:flutter/material.dart';

class DefaultRefreshIndicator extends StatelessWidget {
  DefaultRefreshIndicator({
    required this.refreshFunction,
    required this.child,
  });
  final Future refreshFunction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: -60,
      color: Theme.of(context).primaryColor,
      onRefresh: () async => await refreshFunction.timeout(Duration(seconds: 5)),
      child: child,
    );
  }
}
