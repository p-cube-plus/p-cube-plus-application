import 'dart:async';
import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/utilities/error_message.dart';

class DefaultFutureBuilder extends StatelessWidget {
  DefaultFutureBuilder(
      {required this.refreshData,
      required this.fetchData,
      required this.showFunction})
      : super();

  final Future refreshData;
  final Future fetchData;
  final Function showFunction;

  @override
  Widget build(BuildContext context) {
    Object? refreshError;

    return RefreshIndicator(
      onRefresh: () async {
        try {
          await refreshData.timeout(Duration(seconds: 5));
          refreshError = null;
        } catch (error) {
          refreshError = error;
        }
      },
      child: FutureBuilder(
          future: fetchData.timeout(Duration(seconds: 5)),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${DataLoadTimeout().message}"));
            }
            if (refreshError != null) {
              return Center(child: Text("$refreshError"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 스켈레톤 이미지 들어갈 자리
              return Center(child: CircularProgressIndicator());
            } else {
              return showFunction(snapshot.data);
            }
          }),
    );
  }
}
