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
    if (refreshFunction == null)
      return child;
    else
      return RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: () async => await refreshFunction,
        child: child,
      );
  }
}
