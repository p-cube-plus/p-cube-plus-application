import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('홈'),
          automaticallyImplyLeading: false,
          //leading: IconButton(
          //  icon: const Icon(Icons.arrow_back),
          //  tooltip: '뒤로 가기',
          //  onPressed: () {
          //    Navigator.pop(context);
          //  },
          //),
        ),
        body: Text("준비중"));
  }
}
