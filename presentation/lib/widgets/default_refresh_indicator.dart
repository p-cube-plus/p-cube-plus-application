import 'package:flutter/material.dart';

class DefaultRefreshIndicator extends StatelessWidget {
  const DefaultRefreshIndicator({
    super.key,
    required this.refreshFunction,
    required this.child,
  });
  final Function refreshFunction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: -60,
      color: Theme.of(context).primaryColor,
      onRefresh: () async {
        await refreshFunction();
      },
      child: child,
    );
  }
}
