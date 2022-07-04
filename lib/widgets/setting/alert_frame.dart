import 'package:flutter/material.dart';

enum MessageType {
  OK,
  OKCancel,
}

class AlertFrame extends StatelessWidget {
  final title;
  final children;
  final messageType;
  final okWidget;

  AlertFrame(
      {required Widget this.title,
      required List<Widget> this.children,
      required MessageType this.messageType,
      Widget? this.okWidget});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      title: title,
      content: Builder(builder: (context) {
        //final height = MediaQuery.of(context).size.height;
        //final width = MediaQuery.of(context).size.width;
        return Container(
          //height: height,
          //width: width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        );
      }),
      actions: [
        Row(
          children: _getRowChildren(context),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  List<Widget> _getRowChildren(context) {
    final result = <Widget>[];
    final circular = 15.0;

    result.add(SizedBox(width: 16));

    switch (messageType) {
      case MessageType.OK:
        result.add(ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('확인'),
          style: ElevatedButton.styleFrom(
              minimumSize: Size(364, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(circular))),
        ));
        break;
      case MessageType.OKCancel:
        result.add(OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('취소'),
          style: OutlinedButton.styleFrom(
              minimumSize: Size(174, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(circular))),
        ));
        result.add(SizedBox(width: 16));
        result.add(ElevatedButton(
          onPressed: () => _backFunc(context, okWidget),
          child: Text('확인'),
          style: ElevatedButton.styleFrom(
              minimumSize: Size(174, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(circular))),
        ));
        break;
      default:
    }

    result.add(SizedBox(width: 16));
    return result;
  }

  void _backFunc(context, okWidget) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => okWidget,
    );
  }
}
