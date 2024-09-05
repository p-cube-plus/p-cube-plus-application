import 'package:flutter/material.dart';

class DefaultFutureBuilder<T> extends StatefulWidget {
  const DefaultFutureBuilder(
      {super.key,
      required this.fetchData,
      required this.showOnLoadedWidget,
      this.loadingWidget,
      this.showOnErrorWidget,
      this.handleError});

  final Future<T> fetchData;
  final Widget Function(T data) showOnLoadedWidget;
  final Widget? loadingWidget;
  final Widget Function(Object? error, StackTrace trace)? showOnErrorWidget;
  final void Function(Object? error, StackTrace trace)? handleError;

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
            return widget.loadingWidget ??
                const Center(
                  child: CircularProgressIndicator(),
                );
          }

          try {
            return widget.showOnLoadedWidget(snapshot.requireData);
          } catch (error, trace) {
            widget.handleError?.call(error, trace);
            return widget.showOnErrorWidget?.call(error, trace) ??
                const SizedBox();
          }
        });
  }
}
