import 'dart:async';
import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/utilities/error_message.dart';
import 'package:p_cube_plus_application/widgets/common/default_refreshIndicator.dart';
import 'package:p_cube_plus_application/widgets/common/default_scrollView.dart';

class DefaultFutureBuilder extends StatefulWidget {
  DefaultFutureBuilder(
      {required this.refreshData,
      required this.fetchData,
      required this.showFunction})
      : super();

  final Future refreshData;
  final Future fetchData;
  final Function showFunction;

  @override
  State<DefaultFutureBuilder> createState() => _DefaultFutureBuilderState();
}

class _DefaultFutureBuilderState extends State<DefaultFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return DefaultRefreshIndicator(
      refreshFunction: widget.refreshData.timeout(Duration(seconds: 5)),
      child: FutureBuilder(
          future: widget.fetchData.timeout(Duration(seconds: 5)),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (snapshot.error is TimeoutException)
                return _ErrorWidget(DataLoadTimeout().message);
              else
                return _ErrorWidget(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return widget.showFunction(snapshot.data);
          }),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  _ErrorWidget(this.message);
  String message;

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
