import 'package:flutter/material.dart';

class DefaultFutureBuilder<T> extends StatefulWidget {
  const DefaultFutureBuilder(
      {super.key,
      required this.fetchData,
      required this.showFunction,
      this.loadWidget,
      this.errorWidget,
      this.handleError});

  final Future<T> fetchData;
  final Widget Function(T data) showFunction;
  final Widget? loadWidget;
  final Widget? errorWidget;
  final void Function(Object, StackTrace)? handleError;

  @override
  State<DefaultFutureBuilder> createState() => _DefaultFutureBuilderState();
}

class _DefaultFutureBuilderState<T> extends State<DefaultFutureBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.fetchData,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active) {
            return widget.loadWidget ?? const SizedBox();
          }

          try {
            return widget.showFunction(snapshot.requireData);
          } catch (error, stackTrace) {
            widget.handleError?.call(error, stackTrace);
            return widget.errorWidget ?? const SizedBox();
          }
        });
  }
}
