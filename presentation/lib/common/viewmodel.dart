import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin ViewModel<T> {
  T read(BuildContext context) => context.read<T>();

  Widget watchWidget<R>(
    R Function(T viewModel) selector,
    Widget Function(BuildContext context, R item) builder, {
    bool Function(R previous, R next)? shouldRebuild,
  }) =>
      Selector<T, R>(
        selector: (context, T viewModel) => selector(viewModel),
        builder: (context, R item, _) => builder(context, item),
        shouldRebuild: shouldRebuild,
      );
}

mixin SharedViewModel<T> {
  T sharedRead(BuildContext context) => context.read<T>();
}
