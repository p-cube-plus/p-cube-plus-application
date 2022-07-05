import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈'),
        automaticallyImplyLeading: false,
        //leading: IconButton(
        //  icon: const Icon(Icons.arrow_back),
        //  tooltip: '뒤로 가기',
        //  onPressed: () {
        //    Navigator.pop(context);
        //  },
        //),
      ),
      //body: ,
    );
  }
}
