import 'package:flutter/material.dart';

class DefaultFutureBuilder<T> extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active) {
            return loadingWidget ??
                const Center(
                  child: CircularProgressIndicator(),
                );
          }

          try {
            return showOnLoadedWidget(snapshot.requireData);
          } catch (error, trace) {
            handleError?.call(error, trace);
            return showOnErrorWidget?.call(error, trace) ?? const SizedBox();
          }
        });
  }
}
