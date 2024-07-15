import 'dart:async';
import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/common/utils/error_message.dart';
import 'package:p_cube_plus_application/widgets/common/default_scrollView.dart';

class DefaultFutureBuilder extends StatefulWidget {
  DefaultFutureBuilder(
      {required this.fetchData,
      required this.showFunction,
      this.skeletonLoader})
      : super();

  final Future fetchData;
  final Function showFunction;
  final Widget? skeletonLoader;

  @override
  State<DefaultFutureBuilder> createState() => _DefaultFutureBuilderState();
}

class _DefaultFutureBuilderState extends State<DefaultFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.fetchData.timeout(Duration(seconds: 5)),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            if (widget.skeletonLoader == null)
              return SizedBox();
            else
              return widget.skeletonLoader!;
          }

          if (snapshot.hasError) {
            if (snapshot.error is TimeoutException)
              return _ErrorWidget(DataLoadTimeout().message);
            else
              return _ErrorWidget(snapshot.error.toString());
          }

          if (snapshot.hasData) {
            return widget.showFunction(snapshot.data);
          }

          return widget.showFunction(null);
        });
  }
}

class _ErrorWidget extends StatelessWidget {
  _ErrorWidget(this.message);
  final String message;

  @override
  Widget build(BuildContext context) {
    return DefaultScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height - 250,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Center(
              child: Text("$message"),
            )));
  }
}
