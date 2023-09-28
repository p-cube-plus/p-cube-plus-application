import 'dart:async';
import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/utilities/error_message.dart';

class DefaultFutureBuilder extends StatelessWidget {
  DefaultFutureBuilder({required this.future, required this.showFunction});
  final Future future;
  final Function showFunction;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await future;
      },
      child: FutureBuilder(
          future: future.timeout(Duration(seconds: 5)),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return showFunction(snapshot.data);
            } else if (snapshot.hasError) {
              return Center(child: Text("${DataLoadTimeout().message}"));
            }

            // 스켈레톤 이미지 들어갈 자리
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
