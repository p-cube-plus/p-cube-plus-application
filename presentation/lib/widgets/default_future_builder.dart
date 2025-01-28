import 'package:domain/common/exception/login_expired_exception.dart';
import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/login/usecases/logout_use_case.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/ui/login/login_home/login_home_page.dart';

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

        if (snapshot.error is LoginExpiredException) {
          Fluttertoast.showToast(msg: "세션이 만료되었습니다.\n다시 로그인해주세요.");
          LogoutUseCase().call().getOrNull();
          _goToLoginPage(context);
        } else {
          handleError?.call(snapshot.error, snapshot.stackTrace);
        }

        return showOnErrorWidget?.call(snapshot.error, snapshot.stackTrace) ??
            SizedBox(
              child: Text("${snapshot.error}"),
            );
      },
    );
  }

  void _goToLoginPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => LoginHomePage(),
      ),
      (route) => false,
    );
  }
}
