import 'package:flutter/material.dart';

class DefaultFutureBuilder<T> extends StatelessWidget {
  const DefaultFutureBuilder(
      {super.key,
      required this.fetchData,
      required this.showOnLoadedWidget,
      this.showOnLoadingWidget,
      this.showOnErrorWidget,
      this.handleError});

  final Future<T> fetchData;
  final Widget Function(BuildContext context, T data) showOnLoadedWidget;
  final Widget Function(BuildContext context)? showOnLoadingWidget;
  final Widget Function(Object? error, StackTrace? trace)? showOnErrorWidget;
  final void Function(Object? error, StackTrace? trace)? handleError;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active) {
            return showOnLoadingWidget?.call(context) ??
                const Center(
                  child: CircularProgressIndicator(),
                );
          }

          if (snapshot.hasData) {
            return showOnLoadedWidget(context, snapshot.requireData);
          }

          handleError?.call(snapshot.error, snapshot.stackTrace);
          return showOnErrorWidget?.call(snapshot.error, snapshot.stackTrace) ??
              const SizedBox();
        });
  }
}
